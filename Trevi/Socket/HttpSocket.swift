//
//  HttpSocket.swift
//  Trevi
//
//  Created by JangTaehwan on 2015. 12. 27..
//  Copyright © 2015년 LeeYoseob. All rights reserved.
//

/**
* ClientSocket class
*
* Interface for managing HttpSocket's client
*
*/
public class ClientSocket {
    
    let ip : String
    weak var socket : ConnectedSocket<IPv4>!
    
    public init( socket : ConnectedSocket<IPv4> ){
        self.socket = socket
        self.ip = socket.address.ip()
    }
    
    public func sendData ( data: NSData ) {
        socket.write (data)
    }
    
    public func close(){
        socket.close ()
    }
    
    public func closeAfter( seconds : __uint64_t ) {
        socket.setTimeout(seconds)
    }
}


public protocol RequestHandler{
    func beginHandle(req : Request , _ res :Response )
}

/**
 * HttpSocket class
 *
 * Set http server model and manage http client connections.
 *
 * Dispatch a request handle event.
 *
 */

public class HttpSocket : RequestHandler {
    
    let ip : String?
    var listenSocket : ListenSocket<IPv4>!
    
    var httpCallback : HttpCallback?
    var prepare = PreparedData()
    var totalLength = 0
    
    // If set closeTime a client will be disconnected withn closeTime.
    var closeTime: __uint64_t?
    
    public init(ip : String? = nil){
        self.ip = ip
    }
    
    /**
     * setServerModel
     * Set server model by input dispatch queues. 
     * Tasks in these queues will be processed by threads which is set at inputs.
     *
     * Examples:
     *  self.setServerModel(.MULTI, .MULTI, .SINGLE)
     *
     * @param
     *  First : Client accept queue setting.
     *  Second : Client request read queue setting.
     *  Third : Write response queue setting.
     *
     */
    public func setServerModel(accept : DispatchQueue,
        _ read : DispatchQueue, _ write : DispatchQueue) {
        serverModel.acceptQueue = accept.queue
        serverModel.readQueue = read.queue
        serverModel.writeQueue = write.queue
    }
    
    /**
     * startListening
     * Listen http socket and dispatch client event.
     *
     * @param
     *  First : Server ip set
     *  Second : port setting
     *
     */
    public func startListening ( port : __uint16_t ) throws {
        
        var address : IPv4 {
            get{
                if let ip = self.ip{
                    return IPv4(ip: ip, port: port)
                }
                else{
                    return IPv4(port: port)
                }
            }
        }
        
        guard let listenSocket = ListenSocket<IPv4> ( address: address) else {
            log.error("Could not create ListenSocket on ip : \(self.ip), port : \(port))")
            return
        }
        
        prepare.requestHandler = self
        
        listenSocket.listenClientReadEvent () {
            client in
            
            if let time = self.closeTime {
                client.setTimeout(time)
            }
            return self.prepareRequest(client)
        }
        
        self.listenSocket = listenSocket
    }
    
    public func disconnect () {
        self.listenSocket.close ()
    }
    
    public func beginHandle(req : Request , _ res :Response) {
        self.httpCallback! ( req, res )
        self.prepare.dInit()
    }
    
    private func prepareRequest(client : ConnectedSocket<IPv4>) -> Int{
        let readData = client.read()
        self.totalLength += readData.length
        
        if readData.length > 0 {
            let (contentLength, headerLength) = self.prepare.appendReadData(readData)
            
            if contentLength > headerLength{
                self.totalLength -= headerLength
            }
            if self.totalLength >= contentLength || contentLength == 0{
                let httpClient = ClientSocket ( socket: client )
                self.prepare.handleRequest(httpClient)
            }
        }

        return readData.length
    }
}
