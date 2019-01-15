//
//  ProviderWebSocket.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation
import Starscream // web sockets


public extension IADSB {
    public class ProviderWebSocket: IADSB.ProviderNetwork, WebSocketDelegate {
        
        public var socket:WebSocket
        public var defaultUrl:String { return "" }
        public var subscribeChannel:String? = nil
        
        override public init(_ manager:Manager, priority:Int = 0, alwaysOn:Bool = false) {
            socket = WebSocket(url: URL(string: "http://placeholder")!)
            super.init(manager, priority: priority, alwaysOn: alwaysOn)
            self.url = defaultUrl
        }
        
        public var url:String {
            get {
                return socket.currentURL.absoluteString
            }
            set {
                if let url = URL(string: newValue) {
                    socket = WebSocket(url: url)
                    socket.delegate = self
                }
            }
        }
        
        override public func start() {
            super.start()
            socket.connect()
        }
        
        override public func stop() {
            super.stop()
            socket.disconnect()
        }
        
        override public func checkOnce() {
            // TODO
        }
        
        public func websocketDidConnect(socket: WebSocketClient) {
            print("websocket is connected")
            if let channel = subscribeChannel {
                let data = ["command":"subscribe", "identifier":jsonString(["channel":channel])]
                socket.write(string: jsonString(data))
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
        }
        
        public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
            print("got some text: \(text)")
            if let gps = self.modelFrom(IADSB.Stratux.GPS.self, jsonString: text) {
                print("got gps: \(gps.description)")
            }
        }
        
        public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
            print("got some data: \(data.count)")
        }
    }
}
