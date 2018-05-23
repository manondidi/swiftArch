# swiftArch

swift开发框架

todo:

UI组件 

​      列表: 

- [x] ​        默认状态视图
- [x] ​       可定制状态视图  
- [x] ​       上下拉(可定制) 

- [ ] collectionView(分页解耦)  暂时不打算做

网络库

- [ ] ​              请求聚合

- [ ] ​               缓存(基本完成,待优化)
- [x] ​               自动解析模型<传入泛型>
- [x] ​               参数封装 
- [x] ​               url管理  
- [ ] ​              网络日志

业务层  

- [x] ​	         mock管理

页面

- [x] ​		页面状态视图展示和个性化定制
   - [x] ​分页计算策略模式  
- [x] 列表model解耦
  - [x] section支持(为实现这个功能死了好多脑细胞)



文档

- [ ] ​		使用文档
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



#### 说明

还有许多新功能想做进去,等功能稳定后

过段时间会出一个设计文档和使用文档



