//
//  ProviderWebSocket.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation
import Starscream // web sockets


public extension IADSB {
    public class ProviderWebSocket: IADSB.ProviderNetwork {
        class Delegate:WebSocketDelegate {
            
            var url:String
            var types:[ModelCodable.Type]
            var subscribeChannel:String? = nil
            var socket:WebSocket
            var provider:ProviderWebSocket
            var connected = false
            
            init?( url:String, types:[ModelCodable.Type], provider:ProviderWebSocket, subscribeChannel:String? = nil) {
                self.url = url
                self.types = types
                self.provider = provider
                self.subscribeChannel = subscribeChannel
                if let urlConnection = URL(string: url) {
                    socket = WebSocket(url: urlConnection)
                    socket.delegate = self
                } else {
                    return nil
                }
            }
            
            func start() {
                if !connected {
                    socket.connect()
                }
            }
            
            func stop() {
                connected = false
                socket.disconnect()
            }
            
            public func websocketDidConnect(socket: WebSocketClient) {
                print("websocket is connected")
                if !connected, let channel = subscribeChannel {
                    let data = ["command":"subscribe", "identifier":jsonString(["channel":channel])]
                    print( "Sending subscribe command: \(data)")
                    socket.write(string: jsonString(data))
                    connected = true
                }
            }
            
            func jsonString(_ input:[String:String]) -> String {
                do {
                    let data1 =  try JSONSerialization.data(withJSONObject: input, options: [])
                    let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
                    return convertedString ?? ""
                    
                } catch let myJSONError {
                    print(myJSONError)
                }
                
                return ""
            }
            
            public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
                print("websocket is disconnected: \(error?.localizedDescription ?? "")")
                if connected {
                    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                        self.start()
                    }
                }
                connected = false
            }
            
            public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
                if text.contains("\"type\":\"ping\"") {
                    print("ping")
                    return
                }
                var text = text
                if subscribeChannel != nil { // if json has a channel e.g. Ruby on Rails, take the "message" root from the response
                    if let data = text.data(using: .utf8), let parsedData = try? JSONSerialization.jsonObject(with: data) as? [String:String] {
                        if "confirm_subscription" == parsedData?["type"] {
                            print("CONFIRMED: \(parsedData?["identifier"] ?? "")")
                            return
                        } else if let message = parsedData?["message"] {
                            print("MESSAGE: \(text)")
                            text = message
                        } else {
                            print("NO MESSAGE: \(text)")
                            return
                        }
                    }
                } else {
                    print("RECEIVE: \(text)")
                }

                for type in types {
                    provider.setModelFrom(type.self, jsonString: text)
                }
                provider.manager.update(provider: provider)
            }
            
            public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
                print("got some data: \(data.count)")
            }
        }
        
        var delegates = [Delegate]()
        
        public override init(_ manager:Manager, priority:Int = 0, alwaysOn:Bool = false ) {
            super.init(manager, priority: priority, alwaysOn: alwaysOn)
            
            for connection in self.connections {
                if let delegate = Delegate(url: connection.url, types: connection.types, provider: self, subscribeChannel:connection.subscribeChannel) {
                    delegates.append(delegate)
                }
            }
        }
        
        override public func start() {
            super.start()
            for delegate in delegates {
                delegate.start()
            }
        }
        
        override public func stop() {
            super.stop()
            for delegate in delegates {
                delegate.stop()
            }
        }
        
        override public func checkOnce() {
            // TODO
        }
        
        public var subscribeChannel:String? {
            get {
                return delegates.first?.subscribeChannel
            }
            set {
                for delegate in delegates {
                    delegate.subscribeChannel = newValue
                }
            }
        }
    }
}
