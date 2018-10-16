//
//  ResultError.swift
//  swiftArch
//
//  Created by czq on 2018/10/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
class ResultError: NSError {
 
    var msg=""
    override var localizedDescription: String{
        get{
            return msg
        }
    }
    init( code: Int, msg :String? ) {
        super.init(domain: "requestResult", code: code, userInfo: nil)
        self.msg=msg ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
