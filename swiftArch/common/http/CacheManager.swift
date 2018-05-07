//
//  CacheManager.swift
//  swiftArch
//
//  Created by czq on 2018/5/4.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SQLite
class CacheManager: NSObject {
    var db:Connection?
    let cacheTable = Table("cacheTable")
    let cacheKey = Expression<String>("cacheKey")
    let cacheValue = Expression<String>("cacheValue")
    
    private override init() {
        super.init()
        initCacheDB()
    }
    
    
    static let shareInstance : CacheManager = {
        let instance = CacheManager()
        return instance
    }()
     
    
    func initCacheDB()  {
       
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        db = try? Connection("\(path)/db.sqlite3")
        try? db?.run(cacheTable.create(ifNotExists: true) { t in
            t.column(cacheKey, primaryKey: true)
            t.column(cacheValue)
        })
        
    }
    
    public func saveCache(key:String,value:String){
        _ =  try? db?.run(cacheTable.insert(or: .replace,cacheKey <- key, cacheValue <- value))
        
    }
    public func getCache(key:String)->String?{
        if let cache = try? db?.pluck(cacheTable.select(cacheValue) ){
            let cacheV = try? cache?.get(cacheValue)
            return cacheV!
        }
        return nil;
        
    }


}
