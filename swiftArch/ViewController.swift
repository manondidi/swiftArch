//
//  ViewController.swift
//  swiftArch
//
//  Created by czq on 2018/4/13.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit 
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let httpClient = HttpClient(baseUrl:"http://47.98.129.57:8080/info-admin-web/",headers:["X-Requested-With":"XMLHttpRequest"])
        httpClient.request(url: "user/{userId}", method: .get, pathParams: ["userId":"manondidi" ], params: ["password":"123"])
            .responseModel(success: { (result:Result<User>) in
               
                print(result)
            }, failure: { (result , error) in
                print(result)
                
            })
        }
        
//        .responseModel(success: HandyJSON, failture: HandyJSON)
    
    
 


}

