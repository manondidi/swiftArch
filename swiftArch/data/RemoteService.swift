//
//  RemoteService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

///一个service 持有一个httpclient
///我的意思是 一个httpclient管理一个baseUrl 通常对应一个系统
///同一个系统下面 head cookie 返回值result节点和 sucees条件是一样的
class RemoteService {
    
    let httpClient = HttpClient(baseUrl:DataManager.shareInstance.baseUrl,headers:["X-Requested-With":"XMLHttpRequest"])
    let mockService:MockService=MockService();
    
    
    typealias failureCallback = (_ statusCode:Int?,_ msg:String?) -> Void
    
    func getUser(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping failureCallback ){
        httpClient.request(url: "user/{userId}", method: .get, pathParams: ["userId":userId ], params: ["password":password])
            .responseModelAndCache(success: { (result:Result<User>,isCache:Bool) in
                if(self.checkSuccess(result: result)){
                    success(self.getData(result: result))
                }
                else{
                    failure(result.status,result.msg)
                }
            }, failure: {statusCode,error in
                failure(statusCode,error.localizedDescription)
            })
    }
    
    func getGame(pageNum:Int,pageSize:Int,success:@escaping ((NormalPageModel<GameModel>?)->()),failure:@escaping failureCallback)  {
        httpClient.request(url: "archServer/games", method: .get ,params:["pageNum":"\(pageNum)","pageSize":"\(pageSize)"])
            .responseModel(success: {(result:Result<NormalPageModel<GameModel>>) in
                if(self.checkSuccess(result: result)){
                    success(self.getData(result: result))
                }
                else{
                    failure(result.status,result.msg)
                }
            }, failure: {statusCode,error in
                failure(statusCode,error.localizedDescription)
            })
    }
    
    func getFeedArticle(direction:String,pageSize:Int,offsetId:String?,success:@escaping ((Array<FeedArtileModel>?)->()),failure:@escaping failureCallback)  {
         
        var dic=Dictionary<String, String>()
        dic["pageSize"]="\(pageSize)"
        dic["direction"]=direction
        dic["offsetId"]=offsetId
        httpClient.request(url: "archServer/feeds", method: .get ,params:dic)
             .responseModel(success: {(result:Result<Array<FeedArtileModel>>) in
                if(self.checkSuccess(result: result)){
                    success(self.getData(result: result))
                }
                else{
                    failure(result.status,result.msg)
                }
            }, failure: {statusCode,error in
                failure(statusCode,error.localizedDescription)
            })
    }
    
    func getUserMock(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping failureCallback ){
        mockService.getUser(userId: "", password: "") { (user) in
            success(user)
        }
    }
   
    func getFeedsMock(result callback: @escaping ((Array<SPFeedVM>)->())) {
        mockService.getFeeds { (result: Result<Array<Feed>>) in
            // 转换为VM
            //            var feedVMs? = [SPFeedVM]()
            let tmpFeeds = result.data;
            var feedVMs = tmpFeeds?.map({ (feed: Feed) -> SPFeedVM in
                let feedVM = SPFeedVM()
                feedVM.feed = feed
                return feedVM
            })
            callback(feedVMs!)
        }
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
