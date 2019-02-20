// https://github.com/Quick/Quick

import Quick
import Nimble
import iADSB
import CoreLocation

class TableOfContentsSpec: QuickSpec {
    class Delegate: IADSBDelegate {
        var updateCount:Int = 0
        func update(manager: Manager, device: Device) {
            updateCount += 1
        }
    }
    let delegate = Delegate()
    
    func expectChange(increment:Int, _ value: () -> Int, _ block: () -> Void ) {
        let originalValue = value()
        block()
        let newValue = value()
        expect(newValue) == originalValue + increment
    }
    
    func expectUpdate(increment:Int = 1, _ block: () -> Void ) {
        expectChange(increment: increment, { return self.delegate.updateCount}) {
            block()
        }
    }
    
    override func spec() {
        let manager = Manager()
        let device = Device(manager)
        manager.add(delegate: self.delegate)
        
        describe("has gps") {
            it("can update") {
                self.expectUpdate() {
                    manager.update(device:device)
                }
            }
        }
        
        describe("heading to") {
            it("is magnetic") {
                let sfo = CLLocation(latitude: 37 + 37.13/60.0, longitude: -122 - 22.53/60.0)
                let trk = CLLocation(latitude: 39 + 19.20/60.0, longitude: -120 - 8.37/60.0)
                expect(Constants.Nonnull.headingMagnetic(from: sfo, to: trk)).to(beCloseTo(31.7, within: 0.5))
            }
        }
        describe("these will fail") {

//            it("can do maths") {
//                expect(1) == 2
//            }
//
//            it("can read") {
//                expect("number") == "string"
//            }
//
//            it("will eventually fail") {
//                expect("time").toEventually( equal("done") )
//            }
            
            context("these will pass") {

                it("can do maths") {
                    expect(23) == 23
                }

                it("can read") {
                    expect("🐮") == "🐮"
                }

                it("will eventually pass") {
                    var time = "passing"

                    DispatchQueue.main.async {
                        time = "done"
                    }

                    waitUntil { done in
                        Thread.sleep(forTimeInterval: 0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }
        }
    }
}
