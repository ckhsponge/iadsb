//
//  Manager.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB {
    public class Manager {
        public var providers:[Provider] {
            get {
                return providerCollection.array
            }
            set {
                providerCollection = PriorityCollection(newValue)
            }
        }
        lazy var providerCollection = {
            PriorityCollection([
                IADSB.Stratux.Provider(self, priority: 1),
                IADSB.CoreLocation.Provider(self, priority: 0)
            ])
        }()
        public var gpses = ModelSet<IADSB.GPS>()
        public var barometers = ModelSet<IADSB.Barometer>()
        public var ahrses = ModelSet<IADSB.AHRS>()
        public var traffics = ModelSet<IADSB.Traffic>()
        public var gps:GPS? { return gpses.first }
        public var barometer:Barometer? { return barometers.first }
        public var ahrs:AHRS? { return ahrses.first }
        public var traffic:Traffic? { return traffics.first }
        var delegates = ProtocolSet<IADSBDelegate>()
        
        public var warmupInterval:TimeInterval? = 1 //5*60
        public var peerRetryInterval:TimeInterval? = 15
        public var superiorRetryInterval:TimeInterval? = 10 //30
        var warmupStartedAt:Date? = nil
        var peerRetriedAt:Date? = nil
        var superiorRetriedAt:Date? = nil
        
        public init() {}
        
        public func start() {
            warmupStartedAt = Date()
            for provider in providers {
                provider.start()
            }
        }
        
        public func stop() {
            warmupStartedAt = nil
            for provider in providers {
                provider.stop()
            }
        }
        
        public func setAll(alwaysOn:Bool) {
            for provider in providers {
                provider.alwaysOn = alwaysOn
            }
            if alwaysOn {
                start()
            }
        }
        
        // return the provider of the best GPS and any other providers needed to cover AHRS and Barometer
        // e.g. if CoreLocation has best GPS and Stratux has best AHRS and Barometer then [CoreLocation,Stratux]
        // e.g. if Stratux has best GPS, AHRS and Barometer then [Stratux]
        // (Stratux is higher priority than CoreLocation so most likely will have a higher ranked GPS)
        func requiredProviders() -> Set<Provider> {
            var providers = Set<Provider>()
            if let gpsProvider = gpses.first?.provider {
                providers.insert(gpsProvider)
            }
            let ahrses = self.ahrses
            if let ahrsProvider = ahrses.first?.provider, providers.isDisjoint(with: ahrses.providers) {
                providers.insert(ahrsProvider)
            }
            let barometers = self.barometers
            if let barometerProvider = barometers.first?.provider, providers.isDisjoint(with: barometers.providers) {
                providers.insert(barometerProvider)
            }
            if let trafficProvider = traffics.first?.provider {
                providers.insert(trafficProvider)
            }
            return providers
        }
        
        // checks same priority providers
        func checkPeers(_ requiredProviders:Set<Provider>) {
            guard !requiredProviders.isEmpty, let peerRetryInterval = peerRetryInterval else { return }
            if let retriedAt = peerRetriedAt, retriedAt.timeIntervalBeforeNow < peerRetryInterval {
                return
            }
            let priorities = Set<Int>(requiredProviders.map({ (provider) -> Int in
                provider.priority
            }))
            for priority in priorities {
                for otherProvider in providerCollection.objectsWith(priority:priority) {
                    otherProvider.checkOnce()
                }
            }
            peerRetriedAt = Date()
        }
        
        // checks higher priority providers
        func checkSuperiors(_ requiredProviders:Set<Provider>) {
            guard let superiorRetryInterval = superiorRetryInterval else { return }
            guard let topPriority = requiredProviders.map({ (provider) -> Int in
                provider.priority
            }).max() else { return }
            if let retriedAt = superiorRetriedAt, retriedAt.timeIntervalBeforeNow < superiorRetryInterval {
                return
            }
            for otherProvider in providerCollection.objectsGreaterThan(priority: topPriority) {
                otherProvider.checkOnce()
            }
            superiorRetriedAt = Date()
        }
        
        // officially starts the required providers and stops non-required providers
        func checkRequired(_ requiredProviders:Set<Provider>) {
            if requiredProviders.isEmpty {
                start() // no best provider exists so start them all!
                return
            }
            for provider in requiredProviders {
                if !provider.active {
                    provider.start() // officially start the required provider if it's not already active
                }
            }
            if let warmupInterval = self.warmupInterval, let warmupStartedAt = self.warmupStartedAt, warmupStartedAt.timeIntervalBeforeNow < warmupInterval {
                return // we are still warming up, allow all providers to keep providing
            }
            for otherProvider in providerCollection {
                if !requiredProviders.contains(otherProvider) && otherProvider.active && !otherProvider.alwaysOn {
                    otherProvider.stop()
                }
            }
        }
        
        // a provider has new data, let's store it
        // all data available should be stored in case it is the best
        public func update( provider:IADSB.Provider ) {
//            print("\(String(describing: gps.verticalSpeedFPM))")
            if let gps = provider.gps { gpses.insert(gps) }
            if let barometer = provider.barometer { barometers.insert(barometer) }
            if let ahrs = provider.ahrs { ahrses.insert(ahrs) }
            if let traffic = provider.traffic { traffics.insert(traffic) }
            let requiredProviders = self.requiredProviders()
            checkPeers(requiredProviders)
            checkSuperiors(requiredProviders)
            checkRequired(requiredProviders)
            for delegate in delegates {
                delegate.update(manager:self, provider: provider)
            }
        }
        
        public func fireInactive() {
            for case let delegate as IADSBDelegateInactive in delegates {
                delegate.iadsbInactive()
            }
        }
        
        public func add( delegate:IADSBDelegate ) {
            delegates.add(delegate)
        }
        
        public func remove( delegate:IADSBDelegate ) {
            delegates.remove(delegate)
        }
    }
}
