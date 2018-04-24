//
//  ViewController.swift
//  swiftArch
//
//  Created by czq on 2018/4/13.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit 
class ViewController: UIViewController {

     var remoteService:RemoteService=DataManager.shareInstance.remoteService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteService.getUser(userId: "manondidi", password: "123", success: { (user) in
          print("success")
        }, failure: { (statusCode, msg) in
            print("failure")
        })
       
            
        
        
        
    }

}

