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
class SocialAppService {
    
    let httpClient = HttpClient(baseUrl:DataManager.shareInstance.baseUrlSocail,headers:["X-Requested-With":"XMLHttpRequest"])
    let mockService:MockService=MockService();
    
    
    
    typealias failureCallback = (_ statusCode:Int?,_ msg:String?) -> Void
    
    func getUser(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping failureCallback ){
        httpClient.request(url: "user/{userId}", method: .post, pathParams: ["userId":userId ], params: ["password":password])
            .responseModelAndCache(readCache:true ,success: { (result:Result<User>,isCache:Bool) in
                if(self.checkSuccess(result: result)){
                    success(self.getData(result: result))
                }
                else{
                    failure(result.status,result.msg)
                }
            }, failure: {statusCode,msg in
                failure(statusCode,msg)
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
            }, failure: {statusCode,msg in
                failure(statusCode,msg)
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
            }, failure: {statusCode,msg in
                failure(statusCode,msg)
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
            let tmpFeeds = result.data;
            let feedVMs = tmpFeeds?.map({ (feed: Feed) -> SPFeedVM in
                if let retweetFeed = feed.payload?.post?.retweetFeed {
                    retweetFeed.isRetweeted = true
                }
                let feedVM = SPFeedVM()
                feedVM.feed = feed
                return feedVM
            })
            callback(feedVMs!)
        }
    }
    func getBanners(success:@escaping ((Array<Banner>?)->()),failure:@escaping failureCallback ) {
        mockService.getBanners { (result: Result<Array<Banner>>) in
            success(result.data)
        }
    }
    ///下拉刷新时候 一起请求banner和article的第一页,上拉加载只请求article
    func getBannerAndFeedArticle(direction:String,pageSize:Int,offsetId:String?,success:@escaping ((Array<NSObject>?)->()),failure:@escaping failureCallback)  {
        
        if(direction=="new"){
            var requestCount=2
            var articles:Array<FeedArtileModel>=[]
            let bannerVM:BannersVM=BannersVM()
            self.getFeedArticle(direction: direction, pageSize: pageSize, offsetId: offsetId, success: { (artileList) in
                requestCount-=1
                articles=artileList!
                if(requestCount==0){
                    var list:Array<NSObject>=[NSObject]()
                    list.append(bannerVM)
                    list.append(contentsOf: articles)
                    success(list)
                }
            }) { (code, msg) in
                failure(code, msg)
            }
            self.getBanners(success: { (bannerList) in
                requestCount-=1
                 bannerVM.banners=bannerList
                if(requestCount==0){
                    var list:Array<NSObject>=[NSObject]()
                    list.append(bannerVM)
                    list.append(contentsOf: articles)
                    success(list)
                }
            }) { (code, msg) in
                failure(code, msg)
            }
        }
        else{
            self.getFeedArticle(direction: direction, pageSize: pageSize, offsetId: offsetId, success: { (artileList) in
                    success(artileList)
            }) { (code, msg) in
                failure(code, msg)
            }
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
     
    
  private  func checkSuccess(result:NSObject) -> Bool {
        return true==result.value(forKey: "isSuccess") as? Bool
    }

}
