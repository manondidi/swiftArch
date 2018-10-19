//
//  RemoteService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift
import swiftArch
///一个service 持有一个httpclient
///我的意思是 一个httpclient管理一个baseUrl 通常对应一个系统
///同一个系统下面 head cookie 返回值result节点和 sucees条件是一样的
class SocialAppService {
    
    let httpClient = HttpClient(baseUrl:DataManager.shareInstance.baseUrlSocail,headers:["X-Requested-With":"XMLHttpRequest"])
    let mockService:MockService=MockService();
    
    
    
    typealias failureCallback = (_ statusCode:Int?,_ msg:String?) -> Void
    
    func rxGetUser(userId:String,password:String )->Observable<User>{
      return
        httpClient.rxRequest(url: "user/{userId}", method: .post, pathParams: ["userId":userId ], params: ["password":password])
            .map { result-> User  in
              return try self.getData(result: result)!
            }
        
    }
    
    
    
    func rxGetGame(pageNum:Int,pageSize:Int)->Observable<NormalPageModel<GameModel>> {
        
       return httpClient.rxRequest(url: "archServer/games", method: .get ,params:["pageNum":"\(pageNum)","pageSize":"\(pageSize)"])
            .map{result->NormalPageModel<GameModel> in
                return try self.getData(result: result)!
        }
        
    }
    

    
    func rxGetFeedArticle(direction:String,pageSize:Int,offsetId:String?)->Observable<Array<FeedArtileModel>> {
        
        var dic=Dictionary<String, String>()
        dic["pageSize"]="\(pageSize)"
        dic["direction"]=direction
        dic["offsetId"]=offsetId
        
       return  httpClient.rxRequest(url: "archServer/feeds", method: .get ,params:dic)
        .map({ (result) -> Array<FeedArtileModel> in
            return try  self.getData(result: result)!
        })
    }
    
    
    func rxGetBanners()->Observable<BannersVM> {
       return  mockService.rxGetBanners()
            .map { (result) -> Array<Banner> in
               try self.getData(result: result)!
        }
        .map({ (banners) -> BannersVM in
            let bannersVm=BannersVM()
            bannersVm.banners=banners
            return bannersVm
        })
    }
    
    ///下拉刷新时候 一起请求banner和article的第一页,上拉加载只请求article
    func rxGetBannerAndFeedArticle(direction:String,pageSize:Int,offsetId:String?)->Observable<Array<NSObject>>{
        if(direction=="new"){
            return Observable.zip(self.rxGetBanners(), self.rxGetFeedArticle(direction: direction, pageSize: pageSize, offsetId: offsetId)){ bannersVM,articles in
                var array=[NSObject]()
                array.append(bannersVM )
                array.append(contentsOf: articles)
                return array
            } 
        }else{
            return self.rxGetFeedArticle(direction: direction, pageSize: pageSize, offsetId: offsetId)
                .map({ (articles) -> Array<NSObject> in
                    var array=[NSObject]()
                    array.append(contentsOf: articles)
                    return array
                })
        }
        
    }
    
    func rxGetUserMock(userId:String,password:String)->Observable<User>{
       return  mockService.rxGetUser(userId: "", password: "")
    }
    
    func rxGetFeedsMock()->Observable<Array<SPFeedVM>> {
      return  mockService.rxGetFeeds()
            .map({ (result) -> Array<SPFeedVM> in
                let tmpFeeds = result.data;
                let arrays =  tmpFeeds!.map({ (feed) -> SPFeedVM in
                    if let retweetFeed = feed.payload?.post?.retweetFeed {
                        retweetFeed.isRetweeted = true
                    }
                    let feedVM = SPFeedVM()
                    feedVM.feed = feed
                    return feedVM
                })
                return arrays
            })
        
    }

    
    
    
   private func getData<T>(result:Result<T>) throws  ->T? {
        try self.checkSuccess(result: result)
        return result.data!
    }
     
    
   private  func checkSuccess<T>(result:Result<T>)throws  {
        if  !result.isSuccess{
            throw ResultError(code:result.status!,msg:result.msg)
        }
    }
    

}
