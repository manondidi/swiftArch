//
//  DataProtocol.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
protocol DataProtocol {
    func getUser(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping ((Int?,String?)->()) );
}
