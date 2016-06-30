//
//  StreamListener.swift
//  Trevi
//
//  Created by LeeYoseob on 2016. 2. 1..
//  Copyright © 2016 Trevi Community. All rights reserved.
//

import Foundation

public typealias emitable = (AnyObject) -> Void

public typealias noParamsEvent = (Void) -> Void

public typealias oneStringeEvent = (String) -> Void

public typealias oneDataEvent = (NSData) -> Void

typealias emitterType = ([AnyObject]) -> Void

typealias AnyType = (AnyObject, AnyObject, Any?) -> Void


/*
 This class is an asynchronous data it uses to communicate, and passed to register and invokes the event.
 But now, because there is a limit of the type of all can't transmit the data. Will quickly change to have it
 */

public class EventEmitter{
    
    var events = [String:Any]()
    
    init(){
        
    }
    
    deinit{
        
    }
    
    ///
    /// register event function with name
    ///
    /// - Parameter name: The name of registed event
    /// - Parameter emitter: event be going to registed
    ///
    ///
    public func on(name: String, _ emitter: Any){
        
        guard events[name] == nil  else{
            print("already contain event")
            return
        }
        
        events[name] = emitter
    }
    
    ///
    /// remove event funtion registered
    ///
    /// - Parameter name: The name of stored event
    ///
    ///
    public func removeEvent(name: String){
        events.removeValueForKey(name)
    }
    
    
    ///
    /// invoke registed event with Parameters
    ///
    /// - Parameter name: The name if be going to invoke event
    /// - Parameter arguments: Data send on event
    ///
    ///
    public func emit(name: String, _ arguments : AnyObject...){
        let emitter = events[name]
        
        switch emitter {
        case let callback as HttpCallback:
            
            if arguments.count == 2{
                
                let request = arguments[0] as! IncomingMessage
                let response = arguments[1] as! ServerResponse
                callback(request,response, nil)
                
            } else if arguments.count == 3{
                let request = arguments[0] as! IncomingMessage
                let response = arguments[1] as! ServerResponse
                let next = arguments[2] as! NextCallback
                callback(request,response, next)
            }
            
        case let callback as emitable:
            if arguments.count == 1 {
                callback(arguments.first!)
            }else {
                #if os(Linux)
                    callback(arguments as! AnyObject)
                #else
                    callback(arguments)
                #endif
            }
            
        case let callback as oneStringeEvent:
            if arguments.count == 1 {
                #if os(Linux)
                    let str = arguments.first as! StringWrapper
                    callback(str.string)
                #else
                    callback(arguments.first as! String)
                #endif
            }
            
        case let callback as oneDataEvent:
            if arguments.count == 1 {
                callback(arguments.first as! NSData)
            }
            
        case let callback as noParamsEvent:
            callback()
            
        case let callback as AnyType:
            #if os(Linux)
                callback(StringWrapper(string: ""), StringWrapper(string: ""), nil)
            #else
                callback("" ,"", nil)
            #endif

            
        default:
            print("There is no event")
            break
        }
    }
}




