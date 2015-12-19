//
//  Router.swift
//  Trevi
//
//  Created by LeeYoseob on 2015. 11. 30..
//  Copyright © 2015년 LeeYoseob. All rights reserved.
//

import Foundation

public class Router: Middleware {

    public var  name: MiddlewareName
    public var routeList = [ Route ] ()

    public init () {
        name = .Router
    }

    public func operateCommand ( params: MiddlewareParams ) -> Bool {
        return false
    }
    
    public func appendRoute ( path: String, _ route: Route ) {
        self.routeList.append( route )
        sortRouteList()
    }

    // TODO : why can't get path parameter...?
    public func route ( path: String ) -> Route! {
        
        for route in routeList {
            if path.isMatch( route.regex ) {
                return route
            }
        }
        return nil
    }
    
    private func sortRouteList() {
        routeList = routeList.sort( { $0.regex > $1.regex } )
    }
}