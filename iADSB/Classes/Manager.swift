//
//  Manager.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public class Manager {
    public var devices:[Device] {
        get {
            return deviceCollection.array
        }
        set {
            deviceCollection = PriorityCollection(newValue)
        }
    }
    lazy var deviceCollection = {
        PriorityCollection([
            iADSB.Stratux.Device(self, priority: 1),
            iADSB.CoreLocation.Device(self, priority: 0)
        ])
    }()
    public var gpses = ServiceSet<iADSB.GPS>()
    public var barometers = ServiceSet<iADSB.Barometer>()
    public var ahrses = ServiceSet<iADSB.AHRS>()
    public var traffics = ServiceSet<iADSB.Traffic>()
    public var gps:GPS? { return gpses.first }
    public var barometer:Barometer? { return barometers.first }
    public var ahrs:AHRS? { return ahrses.first }
    public var traffic:Traffic? { return traffics.first }
    
//    private var hasUpdates:Bool = false
    private var delegates = ProtocolSet<IADSBDelegate>()
    
    public var fireUpdateInterval:TimeInterval = 0.5 // must stop and start for changes to take effect
    private var fireUpdateTimer:Timer?
    public var warmupInterval:TimeInterval? = 1 //5*60
    public var peerRetryInterval:TimeInterval? = 15
    public var superiorRetryInterval:TimeInterval? = 10 //30
    var warmupStartedAt:Date? = nil
    var peerRetriedAt:Date? = nil
    var superiorRetriedAt:Date? = nil
    
    // concurrent queue allows simultaneous reads
    private let dispatchQueue = DispatchQueue( label: "net.toonsy.iADSB.manager", attributes: .concurrent)
    
    public init() {}
    
    public func start() {
        warmupStartedAt = Date()
        for device in devices {
            device.start()
        }
        dispatchQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.fireUpdateTimer = Timer.scheduledTimer(withTimeInterval: self.fireUpdateInterval, repeats: true, block: { (timer) in
                self.fireUpdate(delegates: self.delegates.toArray())
            })
            let runLoop = RunLoop.current
            runLoop.add(self.fireUpdateTimer!, forMode: RunLoop.Mode.default)
            runLoop.run()
        }
    }
    
    public func stop() {
        warmupStartedAt = nil
        for device in devices {
            device.stop()
        }
        dispatchQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.fireUpdateTimer?.invalidate()
            self.fireUpdateTimer = nil
        }
    }
    
    public func setAll(alwaysOn:Bool) {
        for device in devices {
            device.alwaysOn = alwaysOn
        }
        if alwaysOn {
            start()
        }
    }
    
    // return the device of the best GPS and any other devices needed to cover AHRS and Barometer
    // e.g. if CoreLocation has best GPS and Stratux has best AHRS and Barometer then [CoreLocation,Stratux]
    // e.g. if Stratux has best GPS, AHRS and Barometer then [Stratux]
    // (Stratux is higher priority than CoreLocation so most likely will have a higher ranked GPS)
    func requiredDevices() -> Set<Device> {
        var devices = Set<Device>()
        if let gpsDevice = gpses.first?.device {
            devices.insert(gpsDevice)
        }
        let ahrses = self.ahrses
        if let ahrsDevice = ahrses.first?.device, devices.isDisjoint(with: ahrses.devices) {
            devices.insert(ahrsDevice)
        }
        let barometers = self.barometers
        if let barometerDevice = barometers.first?.device, devices.isDisjoint(with: barometers.devices) {
            devices.insert(barometerDevice)
        }
        if let trafficDevice = traffics.first?.device {
            devices.insert(trafficDevice)
        }
        return devices
    }
    
    // checks same priority devices
    func checkPeers(_ requiredDevices:Set<Device>) {
        guard !requiredDevices.isEmpty, let peerRetryInterval = peerRetryInterval else { return }
        if let retriedAt = peerRetriedAt, retriedAt.timeIntervalBeforeNow < peerRetryInterval {
            return
        }
        let priorities = Set<Int>(requiredDevices.map({ (device) -> Int in
            device.priority
        }))
        for priority in priorities {
            for otherDevice in deviceCollection.objectsWith(priority:priority) {
                otherDevice.checkOnce()
            }
        }
        peerRetriedAt = Date()
    }
    
    // checks higher priority devices
    func checkSuperiors(_ requiredDevices:Set<Device>) {
        guard let superiorRetryInterval = superiorRetryInterval else { return }
        guard let topPriority = requiredDevices.map({ (device) -> Int in
            device.priority
        }).max() else { return }
        if let retriedAt = superiorRetriedAt, retriedAt.timeIntervalBeforeNow < superiorRetryInterval {
            return
        }
        for otherDevice in deviceCollection.objectsGreaterThan(priority: topPriority) {
            otherDevice.checkOnce()
        }
        superiorRetriedAt = Date()
    }
    
    // officially starts the required devices and stops non-required devices
    func checkRequired(_ requiredDevices:Set<Device>) {
        if requiredDevices.isEmpty {
            start() // no best device exists so start them all!
            return
        }
        for device in requiredDevices {
            if !device.active {
                device.start() // officially start the required device if it's not already active
            }
        }
        if let warmupInterval = self.warmupInterval, let warmupStartedAt = self.warmupStartedAt, warmupStartedAt.timeIntervalBeforeNow < warmupInterval {
            return // we are still warming up, allow all devices to keep providing
        }
        for otherDevice in deviceCollection {
            if !requiredDevices.contains(otherDevice) && otherDevice.active && !otherDevice.alwaysOn {
                otherDevice.stop()
            }
        }
    }
    
    // a device has new data, let's store it
    // all data available should be stored in case it is the best
    public func update( device:iADSB.Device ) {
//            print("\(String(describing: gps.verticalSpeedFPM))")
        dispatchQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            if let gps = device.gps { self.gpses.insert(gps) }
            if let barometer = device.barometer { self.barometers.insert(barometer) }
            if let ahrs = device.ahrs { self.ahrses.insert(ahrs) }
            if let traffic = device.traffic { self.traffics.insert(traffic) }
            let requiredDevices = self.requiredDevices()
            self.checkPeers(requiredDevices)
            self.checkSuperiors(requiredDevices)
            self.checkRequired(requiredDevices)
        }
    }
    
//    private var delegatesSafe:[IADSBDelegate] {
//        var safe:[IADSBDelegate]!
//        dispatchQueue.sync {
//            safe = self.delegates.toArray()
//        }
//        return safe
//    }
//    
//    public func fireUpdate() {
//        fireUpdate(delegates: delegatesSafe)
//    }
    
    private func fireUpdate(delegates:[IADSBDelegate]) {
        print("FireUpdate \(delegates.count)")
        DispatchQueue.main.async {
            for delegate in delegates {
                delegate.update(manager:self)
            }
        }
    }
    
//    public func fireInactive() {
//        let safe = delegatesSafe
//        DispatchQueue.main.async {
//            for case let delegate as IADSBDelegateInactive in safe {
//                delegate.iadsbInactive()
//            }
//        }
//    }
    
    public func add( delegate:IADSBDelegate ) {
        dispatchQueue.async(flags: .barrier) { [weak self] in
            self?.delegates.add(delegate)
        }
    }
    
    public func remove( delegate:IADSBDelegate ) {
        dispatchQueue.async(flags: .barrier) { [weak self] in
            self?.delegates.remove(delegate)
        }
    }
}

