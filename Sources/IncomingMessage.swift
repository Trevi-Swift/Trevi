//
//  IncomingMessage.swift
//  Trevi
//
//  Created by LeeYoseob on 2016. 3. 3..
//  Copyright © 2016 Trevi Community. All rights reserved.
//

import Foundation

//  Class we use to handle a request.
public class IncomingMessage: StreamReadable{
    
    public var socket: Socket!
    
    public var connection: Socket!
    
    // HTTP header
    public var header: [ String: String ]!
    
    public var httpVersionMajor: String = "1"
    
    public var httpVersionMinor: String = "1"
    
    public var version : String{
        return "\(httpVersionMajor).\(httpVersionMinor)"
    }
    
    public var method: HTTPMethodType!
    
    // Seperated path by component from the requested url
    public var pathComponent: [String] = [ String ] ()
    
    // Qeury string from requested url
    // ex) /url?id="123"
    public var query = [ String: String ] ()
    
    public var path = ""
    
    public var hasBody: Bool!
    
    //server only
    public var url: String!
    
    
    //response only
    public var statusCode: String!
    public var client: AnyObject!
    
    public init(socket: Socket){

        super.init()
        self.socket = socket
        self.connection = socket
        self.client = socket
    }
    
    deinit{
        socket = nil
        connection = nil
        client = nil
    }
    
    public override func _read(n: Int) {
        
    }
}
