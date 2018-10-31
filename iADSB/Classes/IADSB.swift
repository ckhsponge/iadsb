public struct IADSB {
    public struct Stratux {}
    public struct CoreLocation {}
    
    public class Model: Comparable {
        public static func < (lhs: IADSB.Model, rhs: IADSB.Model) -> Bool {
            return lhs.lessThan( rhs )
        }
        public func lessThan(_ rhs: IADSB.Model) -> Bool {
            return self.provider?.name ?? "" < rhs.provider?.name ?? ""
        }
        
        public static func == (lhs: IADSB.Model, rhs: IADSB.Model) -> Bool {
            return lhs.isEqual(rhs)
        }
        public func isEqual(_ rhs: IADSB.Model) -> Bool {
            return self == rhs
        }
        
        public class var keyMapping:[String:String]? { return nil }
        public required init() {}
        public var provider:IADSB.Provider?
    }
}
