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
        var gpsSet = ModelSet<IADSB.GPS>()
        var barometerSet = ModelSet<IADSB.Barometer>()
        var ahrsSet = ModelSet<IADSB.AHRS>()
        var delegates = ProtocolSet<IADSBDelegate>()
        public var gpses:[IADSB.GPS] { return gpsSet.models }
        public var barometers:[IADSB.Barometer] { return barometerSet.models }
        public var ahrses:[IADSB.AHRS] { return ahrsSet.models }
        
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
        func requiredProviders() -> Set<Provider> {
            var providers = Set<Provider>()
            if let gpsProvider = gpses.first?.provider {
                providers.insert(gpsProvider)
            }
            let ahrses = self.ahrses
            if let ahrsProvider = ahrses.first?.provider, isDisjoint(providers:providers, models:ahrses) {
                providers.insert(ahrsProvider)
            }
            let barometers = self.barometers
            if let barometerProvider = barometers.first?.provider, isDisjoint(providers:providers, models:barometers) {
                providers.insert(barometerProvider)
            }
            return providers
        }
        
        // returns true if there is no overlap of the providers and models providers
        func isDisjoint(providers:Set<Provider>, models:[Model]) -> Bool {
            for model in models {
                if let provider = model.provider, providers.contains(provider) {
                    return false
                }
            }
            return true
        }
        
        // checks same priority providers
        func checkPeers(_ requiredProviders:Set<Provider>) {
            guard !requiredProviders.isEmpty, let peerRetryInterval = peerRetryInterval else { return }
            if let retriedAt = peerRetriedAt, -1.0 * retriedAt.timeIntervalSinceNow < peerRetryInterval {
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
            if let retriedAt = superiorRetriedAt, -1.0 * retriedAt.timeIntervalSinceNow < superiorRetryInterval {
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
            if let warmupInterval = self.warmupInterval, let warmupStartedAt = self.warmupStartedAt, -1.0 * warmupStartedAt.timeIntervalSinceNow < warmupInterval {
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
        func update( provider:IADSB.Provider ) {
//            print("\(String(describing: gps.verticalSpeedFPM))")
            if let gps = provider.gps { gpsSet.add(gps) }
            if let barometer = provider.barometer { barometerSet.add(barometer) }
            if let ahrs = provider.ahrs { ahrsSet.add(ahrs) }
            let requiredProviders = self.requiredProviders()
            checkPeers(requiredProviders)
            checkSuperiors(requiredProviders)
            checkRequired(requiredProviders)
            for delegate in delegates {
                delegate.update(provider: provider)
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
