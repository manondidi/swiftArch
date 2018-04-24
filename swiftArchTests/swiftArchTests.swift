//
//  swiftArchTests.swift
//  swiftArchTests
//
//  Created by czq on 2018/4/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import XCTest
class swiftArchTests: XCTestCase {
    
    
    func testExample() {
        let httpClient = HttpClient(baseUrl:"http://47.98.129.57:8080/info-admin-web/",headers:["X-Requested-With":"XMLHttpRequest"])
        httpClient.request(url: "user/{userId}", method: .get, pathParams: ["userId":"manondidi" ], params: ["password":"123"])
            .response { response in
               print(response)
        }
        
        
        
        
    }
    
    
}
