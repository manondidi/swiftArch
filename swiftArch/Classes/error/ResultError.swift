//
//  ResultError.swift
//  swiftArch
//
//  Created by czq on 2018/10/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
public class ResultError: NSError {
 
    public var msg=""
    override public var localizedDescription: String{
        get{
            return msg
        }
    }
    public init( code: Int, msg :String? ) {
        super.init(domain: "requestResult", code: code, userInfo: nil)
        self.msg=msg ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
