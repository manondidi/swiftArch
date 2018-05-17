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
        self.tableView?.setRefreshCallback {
            self.onTableRresh()
        }
        self.tableView?.setLoadMoreCallback {
             self.onTableLoadMore()
        }
        
        self.tableView?.dataSource=self;
        self.tableView?.delegate=self;
    }
    
    
    ///子类可以重写 用于注册sectionHeader和模型的关系
    func registerSectionHeaderModel()  {
        
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
        self.tableView?.showError()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(self.sectionData.count==0){
            return self.dataSource.count
            
        }else{
            return self.sectionData[section].count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var sectionDataSource = Array<NSObject>()
        
        if(self.sectionData.count==0){
              sectionDataSource = self.dataSource
            
        }else{
              sectionDataSource = self.sectionData[indexPath.section]
        }
       let item=sectionDataSource[indexPath.row]
       let cellKey=String(describing:item.classForCoder.self)
       let cell = tableView.dequeueReusableCell(withIdentifier: cellKey)
       cell?.setValue(item, forKey: "model")
       return cell!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section<self.sectionModelList.count) { 
            let item=self.sectionModelList[section]
            let header:UIView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing:item.classForCoder.self))!
            header.setValue(item, forKey: "model")
            return header
        }
         return nil
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
        
        if sectionCount == 0 {
            sectionData.removeAll()
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
        return sectionCount==0 ? 1:sectionCount
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView?.beginRefresh()
    }
    
    
 
    
    
}
