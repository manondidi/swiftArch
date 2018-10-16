# swiftArch

先下载下来看看代码,从/demo/XXXviewcontroller开始看

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

### swift开发框架



说明文档: https://github.com/manondidi/swiftArch/blob/master/%E4%BD%BF%E7%94%A8%E6%96%87%E6%A1%A3.md



todo:

UI组件 

​      列表: 

- [x] ​        默认状态视图
- [x] ​       可定制状态视图  
- [x] ​       上下拉(可定制) 

- [x] **collectionView(分页解耦)**  

网络库

- [x] ​             rxAlamofire

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
   - [x] 分页计算策略模式  
- [x] 列表model解耦
  - [x] section支持



文档

- [x] ​		使用文档
   - [x] ​详细例子


- [ ] 代码生成器







