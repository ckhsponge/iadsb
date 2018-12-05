public struct IADSB {
    public struct Stratux {}
    public struct CoreLocation {}
    
    public class Model: Comparable {
        public static func < (lhs: IADSB.Model, rhs: IADSB.Model) -> Bool {
            return lhs.lessThan( rhs )
        }
        public func lessThan(_ rhs: IADSB.Model) -> Bool {
            return comparableArray.lexicographicallyPrecedes(rhs.comparableArray) || self.provider?.name ?? "" < rhs.provider?.name ?? ""
        }
        
        public static func == (lhs: IADSB.Model, rhs: IADSB.Model) -> Bool {
            return lhs.isEqual(rhs)
        }
        public func isEqual(_ rhs: IADSB.Model) -> Bool {
            return comparableArray == rhs.comparableArray && self.provider?.name ?? "" == rhs.provider?.name ?? ""
        }
        
        public class var keyMapping:[String:String]? { return nil }
        public var provider:IADSB.Provider?
        public var createdAt:Date = {Date()}()
        var comparableArray:[Double] { return [Double]() }
        
        public required init() {
        }
    }
}
