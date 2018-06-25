# swiftArch

swift开发框架

简书详细说明地址 从零开始搭建swift开发框架 :https://www.jianshu.com/p/aac5dec83959  

  

说明文档: https://github.com/manondidi/swiftArch/blob/master/%E4%BD%BF%E7%94%A8%E6%96%87%E6%A1%A3.md



todo:

UI组件 

​      列表: 

- [x] ​        默认状态视图
- [x] ​       可定制状态视图  
- [x] ​       上下拉(可定制) 

- [x] **collectionView(分页解耦)**  

网络库

- [ ] ​              请求聚合(还没想到怎么做,替代方案是在service层用requestcount做聚合控制,详见

      SocialAppService -getBannerAndFeedArticle

- [x] ​               缓存

- [x] ​               自动解析模型<传入泛型>

- [x] ​               参数封装 

- [x] ​               url管理  

- [x] ​              网络日志

- [ ] ​             ~~上传(使用alamofire自带,已经很棒了)~~

- [ ] ​              ~~下载(使用alamofire自带,已经很棒了)~~

- [ ] ~~cookie(使用alamofire自带,已经很棒了)~~

业务层  

- [x] ​	         mock管理

页面

- [x] ​		页面状态视图展示和个性化定制
   - [x] ​分页计算策略模式  
- [x] 列表model解耦
  - [x] section支持



文档

- [x] ​		使用文档
   - [x] ​详细例子


- [ ] 代码生成器





#### 说明

工程使用swift4.1 

引用了如下的第三方 

    pod 'Alamofire', '~> 4.7'  网络库
    pod 'HandyJSON', '~> 4.1.1' json解析库
    pod 'SQLite.swift', '~> 0.11.5' sql库
    pod 'SnapKit', '~> 4.0.0'  autulayout库
    pod 'R.swift'   资源管理库
    pod 'MJRefresh' 下拉刷新库
    pod 'Closures'  类似oc上的blockkit,非常方便
    pod 'Toast-Swift', '~> 3.0.1'  toast库
    pod 'Kingfisher', '~>4.8.0'  网络图片库


#### 安装

1.cd进工程目录 pod install

2.如果你不支持swift4.1 请自行升级xcode

3.由于使用了[R.swift](https://github.com/mac-cain13/R.swift) 所以pod install之后无法直接运行

可以参考R.swfit的配置  

我直接说明下也可以

cmd+b build整个工程 如果成功 可以打开工程文件夹

看到 R.generated.swift 文件 

同时工程里的 R.generated.swift不再是红色

那么开始运行吧



#### 说明(没耐心看的直接从 6.PagingViewController 开始看 )

[使用文档](https://github.com/manondidi/swiftArch/blob/master/%E4%BD%BF%E7%94%A8%E6%96%87%E6%A1%A3.md)	



demo截图

![](https://raw.githubusercontent.com/manondidi/swiftArch/master/%E6%88%AA%E5%9B%BE/demo%E9%A6%96%E9%A1%B5.png)





![](https://raw.githubusercontent.com/manondidi/swiftArch/master/%E6%88%AA%E5%9B%BE/%E5%8A%A8%E6%80%81%E5%88%97%E8%A1%A8.png)



![](https://raw.githubusercontent.com/manondidi/swiftArch/master/%E6%88%AA%E5%9B%BE/%E6%9C%80%E6%96%B0%E6%B8%B8%E6%88%8F%E5%88%97%E8%A1%A8-section.png))









![](https://raw.githubusercontent.com/manondidi/swiftArch/master/%E6%88%AA%E5%9B%BE/%E8%AE%B0%E5%BF%86%E7%82%B9%E9%A6%96%E9%A1%B5.png)

 















 ![多类型CollectionViewCell,自动分页](https://raw.githubusercontent.com/manondidi/swiftArch/master/%E6%88%AA%E5%9B%BE/多类型CollectionViewCell,自动分页.png)

​    

##### 



 



