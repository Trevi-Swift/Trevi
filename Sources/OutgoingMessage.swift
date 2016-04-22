//
//  HttpStream.swift
//  Trevi
//
//  Created by LeeYoseob on 2016. 3. 3..
//  Copyright © 2016 Trevi Community. All rights reserved.
//

import Foundation

// To be class parents who have the data for processing of response.

public class OutgoingMessage {
    
    public var socket: Socket!
    public var connection: Socket!
    
    public var header: [String: String]!
    public var shouldKeepAlive = false
    public var chunkEncoding = false
    
    public init(socket: AnyObject){
        header = [String: String]()
    }
    deinit{
        socket  = nil
        connection = nil
    }
    public func _end(data: NSData, encoding: Any! = nil){
        self.socket.write(data, handle: self.socket.handle)
        if shouldKeepAlive == false {
            self.socket.close()
        }
    }
}

