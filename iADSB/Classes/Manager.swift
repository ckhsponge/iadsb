//
//  Manager.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB {
    public class Manager {
        public lazy var providers:[Provider] = [IADSB.Stratux.Provider(self),IADSB.CoreLocation.Provider(self)]
        var delegates = Array<IADSBDelegate>()
        
        public init() {}
        
        public func start() {
            for provider in providers {
                provider.start()
            }
        }
        
        func update( provider:IADSB.Provider ) {
//            print("\(String(describing: gps.verticalSpeedFPM))")
            for delegate in delegates {
                delegate.update(provider: provider)
            }
        }
        
        public func add( delegate:IADSBDelegate ) {
            if has( delegate: delegate ) {
                return
            }
            delegates.append(delegate)
        }
        
        public func has( delegate:IADSBDelegate ) -> Bool {
            return indexOf(delegate:delegate) != nil
        }
        
        public func remove( delegate:IADSBDelegate ) {
            if let index = indexOf(delegate: delegate ) {
                delegates.remove(at: index)
            }
        }
        
        public func indexOf( delegate:IADSBDelegate ) -> Int? {
            for (index, d) in delegates.enumerated() {
                if d === delegate {
                    return index
                }
            }
            return nil
        }
    }
}
