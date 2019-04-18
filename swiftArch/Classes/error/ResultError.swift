//
//  ResultError.swift
//  swiftArch
//
//  Created by czq on 2018/10/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
public class ResultError: NSError {

    public var reason = ""
    override public var localizedDescription: String {
        get {
            return reason
        }
    }
    public convenience init(code: Int, msg: String?) {
        self.init(domain: "ResultError", code: code, userInfo: nil)
        self.reason = msg ?? ""
    } 
}
