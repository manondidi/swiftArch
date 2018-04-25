//
//  RemoteService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class RemoteService {
    
    let httpClient = HttpClient(baseUrl:DataManager.shareInstance.baseUrl,headers:["X-Requested-With":"XMLHttpRequest"])
    let mockService:MockService=MockService();
    
    
    func getUser(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping ((Int?,String?)->()) ){
        httpClient.request(url: "user/{userId}", method: .get, pathParams: ["userId":"manondidi" ], params: ["password":"123"])
            .responseModel(success: { (result:Result<User>) in 
                if(self.checkSuccess(result: result)){
                    success(self.getData(result: result))
                }
                else{
                    failure(result.status,result.msg)
                }
            }, failure: {statusCode,error in
                failure(statusCode,error.localizedDescription)
            })
        
        //如果接口还没做好,而我们又知道了接口的格式
        //可以将json字符串 保存在本地json文件里面 通过mockservice进行调试
//        在此处
        
//       success( mockService.getUser(userId: userId, password: password))
    }
    
    
    
    
    
   private func getData<T>(result:Result<T>)->T?{
        if self.checkSuccess(result: result) {
            return result.data;
        }
        else{
            return nil
        }
    }
    
  private  func checkSuccess<T>(result:Result<T>) -> Bool {
        return result.status==0
    }

}
