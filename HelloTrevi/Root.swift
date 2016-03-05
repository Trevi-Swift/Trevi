//
//  Lime.swift
//  Trevi
//
//  Created by LeeYoseob on 2015. 12. 1..
//  Copyright © 2015년 LeeYoseob. All rights reserved.
//

import Foundation
import Lime

public class Root{
    
    private let lime = Lime()
    private var router: Router!
    
    public init(){
        
        router = lime.router
        
        router.get("/") { req , res , next in
            res.render("index.ssp", args: ["title":"Trevi"])
        }
        
        router.get("/index") { req , res , next in
            res.write("index get")
            res.end()
        }
        
        router.post("/index") { req , res , next in
            print("\(req.body["name"])")
            res.send("index post")
        }
        
        router.get("/lime") { req , res , next in
            res.write("lime get")
            res.end()
        }
        
        router.get("/trevi/:param1") { req , res , next in
            print("[GET] /trevi/:praram")
        }
    }
}

extension Root: Require{
    public func export() -> Router {
        return self.router
    }
}
