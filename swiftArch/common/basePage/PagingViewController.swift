//
//  PagingViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

//用于计算分页
class PagingViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
 
    var tableView:StateTableView?
    
    var pagingStrategy:PagingStrategy?
    
    private var dataSource = Array<NSObject>()
    private var sectionModelList =  Array<NSObject>()
    
    private var sectionData = Array<Array<NSObject>>()
    
    
    override func initView() {
        super.initView()
        self.pagingStrategy=self.getPagingStrategy()
        self.initTableView()
        self.registerCellModel()
        self.registerSectionHeaderModel()
        self.setTalbeStateView()
        self.tableView?.setUpState()
        self.tableView?.tableFooterView=UIView()
        self.tableView?.setRefreshCallback {[weak self] in
            self?.onTableRresh()
        }
        self.tableView?.setLoadMoreCallback {[weak self] in
             self?.onTableLoadMore()
        }
        
        self.tableView?.dataSource=self;
        self.tableView?.delegate=self;
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    
    ///子类可以重写 用于注册sectionHeader和模型的关系
    ///框架已经帮你做好了 emptyHeader的注册
    /// 使用sectionheader的规则是 sh=sectionheederModel c=cellModel 如下
    /// 正确 sh,c....sh,c...     错误 c...sh
    ///但是由于业务需要不可能一开始就是section所以,所以往数组的起始位置塞入EmptyHeaderModel对象做占位
    func registerSectionHeaderModel()  {
        self.tableView?.registerHeaderClass(headerClass: EmptyHeader.self, modelClass: EmptyHeaderModel.self)
        
    }
    
    ///子类必须重写 用于注册cell和模型的关系
    func registerCellModel()  {
        
//        self.tableView?.registerCellNib(nib: <#T##UINib#>, modelClass: <#T##AnyClass#>)
//        self.tableView?.registerCellClass(cellClass: <#T##AnyClass#>, modelClass: <#T##AnyClass#>)
    }
    
    
    ///提供分页策略 必须重写
    func getPagingStrategy() -> PagingStrategy {
       return NormalPagingStrategy(startPageNum: 1)
    }
    
    ///子类可以重写
    /// 用于个性化定制整个页面的cover,用法:子类覆盖该方法
    /// example: sateManager.setLoadView(view: )
    /// - Parameter sateManager: 页面的管理器
    override func setStateManagerView(sateManager: PageSateManager) {}
  
    
    func  onTableRresh() {
        self.pagingStrategy?.resetPage()
        if self.dataSource.count==0 {
            self.tableView?.showLoading()
        }
        self.onLoadData(pagingStrategy: self.pagingStrategy!)
    }
    func onTableLoadMore(){
        self.onLoadData(pagingStrategy:self.pagingStrategy!)
    }
    
    ///子类必须重写
    func onLoadData(pagingStrategy:PagingStrategy){
    }
    
    /// 子类单页面需要个性化定制tablevview的stateCover请重写
    ///如果采用默认的stateCover那就不需要重写
    ///example:self.tableView?.setLoadView(view: )
    func setTalbeStateView(){}
    
    
    /// 用于个性化提供tableView 用法:子类重写
    ///我的这个tableview是默认添加在self.view的
    /// 如果你的页面tableview有别的初始化方式 比方说nib
    ///或者 tableview不是添加在self.view
    ///或者大小位置需要自定义,你可以重写这个方法
    func initTableView(){//子类重写(如果有必要)
        self.tableView=StateTableView()
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints({ (make) in
            make.width.height.equalToSuperview()
        }) 
        self.tableView?.estimatedSectionHeaderHeight = 0
    }
    

    ///
    /// - Parameters:
    ///   - resultData: 完整的返回值(因为我要从里面取分页信息比如total)
    ///   - dataSource: 完整的列表的数组(用于展示)
    ///   - pagingList: 分页相关的列表数组
    func loadSuccess(resultData:NSObject,dataSource:Array<NSObject>,pagingList:Array<NSObject>){
        self.tableView?.showContent()
        self.pagingStrategy?.addPage(info: pagingList)
        let isFinish=self.pagingStrategy?.checkFinish(result: resultData, listSize: pagingList.count)
        self.tableView?.setLoadMoreEnable(b:!isFinish! )
        if(dataSource.count==0){
            self.tableView?.showEmpty()
        }
        self.dataSource.removeAll()
        self.dataSource += dataSource
        self.tableView?.reloadData()
    }
    func loadFail(){
        if(self.dataSource.count==0){
            self.tableView?.showError()
        }else{
            self.view.makeToast("加载失败")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(self.sectionData.count==0){
            return self.dataSource.count
            
        }else{
            return self.sectionData[section].count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       let item=self.getRealDataSourceModel(indexPath: indexPath)
       let cellKey=String(describing:item.classForCoder.self)
       let cell = tableView.dequeueReusableCell(withIdentifier: cellKey)
       cell?.setValue(item, forKey: "model")
       self.registerEventforCell(cell: cell!, model: item)
       return cell!
    }
    
    ///子类重写去注册cell或者cell内部的事件
    func registerEventforCell(cell:UITableViewCell,model:NSObject){}
    
    
    ///子类重写去注册header或者header内部的事件
    func registerEventforSectionHeader(header:UIView,model:NSObject){}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section<self.sectionModelList.count) { 
            let item=self.sectionModelList[section]
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing:item.classForCoder.self))!
            header.setValue(item, forKey: "model")
            self.registerEventforSectionHeader(header: header,model: item)
            return header
        }
         return UIView()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
       self.sectionModelList=Array<NSObject>()
       let sectionCount = self.dataSource.filter { (data) -> Bool in
          let isSectionModel = (tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing:data.classForCoder.self)) != nil)
          if(isSectionModel){
            self.sectionModelList.append(data)
          }
           return isSectionModel
        }.count
        
        //没有section类型的model
        if sectionCount == 0 {
            sectionData.removeAll()
            return 1
        }else{
            var dataInSection:Array<NSObject>?=nil
            self.dataSource.forEach { (data) in
                if(self.sectionModelList.contains(data)){
                    if(dataInSection != nil){
                        self.sectionData.append( dataInSection!)
                    }
                    dataInSection = Array<NSObject>()
                }else{
                    dataInSection!.append(data)
                }
            }  
            self.sectionData.append( dataInSection!)
        }
        return sectionCount
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView?.beginRefresh()
    }
    
    
    func getRealDataSourceModel(indexPath: IndexPath) -> NSObject {
        var sectionDataSource = Array<NSObject>()
        if(self.sectionData.count==0){
            sectionDataSource = self.dataSource 
        }else{
            sectionDataSource = self.sectionData[indexPath.section]
        }
        let item=sectionDataSource[indexPath.row]
        return item
    }
    
    ///禁止重写 因为你的indexpath用子类的datasource取到的不一定是真正的数据源,看下getRealDataSourceModel方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item:NSObject = self.getRealDataSourceModel(indexPath: indexPath)
        return self.tableView(tableView, heightForModel: item)
    }
    
    
    
    //默认使用autolayout方式
    //你可以重写
    func tableView(_ tableView: UITableView,heightForModel model: NSObject)->CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
