//
//  PagingViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import CocoaLumberjack
//用于计算分页
open class PagingTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    public var tableView: StateTableView?

    public var pagingStrategy: PagingStrategy?

    public var dataSource = Array<Any>()

    public var pagingList = Array<Any>()

    private var sectionModelList = Array<Any>()

    private var sectionData = Array<Array<Any>>()


    open override func initView() {
        super.initView()
        self.pagingStrategy = self.getPagingStrategy()
        self.initTableView()
        self.registerCellModel()
        self.registerSectionHeaderModel()
        self.createTalbeStateView()
        self.tableView?.setUpState()
        self.tableView?.tableFooterView = UIView()
        self.tableView?.setRefreshCallback { [weak self] in
            self?.onTableRresh()
        }
        self.tableView?.setLoadMoreCallback { [weak self] in
            self?.onTableLoadMore()
        }
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }


    ///子类可以重写 用于注册sectionHeader和模型的关系
    ///框架已经帮你做好了 emptyHeader的注册
    /// 使用sectionheader的规则是 sh=sectionheederModel c=cellModel 如下
    /// 正确 sh,c....sh,c...     错误 c...sh
    ///但是由于业务需要不可能一开始就是section所以,所以往数组的起始位置塞入EmptyHeaderModel对象做占位
    open func registerSectionHeaderModel() {
        self.tableView?.registerHeaderClass(headerClass: EmptyHeader.self, modelClass: EmptyHeaderModel.self)

    }

    ///子类必须重写 用于注册cell和模型的关系
    open func registerCellModel() {

//        self.tableView?.registerCellNib(nib: <#T##UINib#>, modelClass: <#T##AnyClass#>)
//        self.tableView?.registerCellClass(cellClass: <#T##AnyClass#>, modelClass: <#T##AnyClass#>)
    }


    ///提供分页策略 必须重写
    open func getPagingStrategy() -> PagingStrategy? {
        return nil
    }

   

    open func onTableRresh() {
        self.pagingStrategy?.resetPage()
        if self.dataSource.count == 0 {
            self.tableView?.showLoading()
        }
        self.loadData()
    }
    
    open func loadData(){
        self.onLoadData(pagingStrategy: self.pagingStrategy)
    }
    
    open func onTableLoadMore() {
        self.loadData()
    }

    ///子类必须重写
    open func onLoadData(pagingStrategy: PagingStrategy?) {
    }

    /// 子类单页面需要个性化定制tablevview的stateCover请重写
    ///如果采用默认的stateCover那就不需要重写
    ///example:self.tableView?.setLoadView(view: )
    open func createTalbeStateView() { }


    /// 用于个性化提供tableView 用法:子类重写
    ///我的这个tableview是默认添加在self.view的
    /// 如果你的页面tableview有别的初始化方式 比方说nib
    ///或者 tableview不是添加在self.view
    ///或者大小位置需要自定义,你可以重写这个方法
    open func initTableView() { //子类重写(如果有必要)
        self.tableView = StateTableView()
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        self.tableView?.estimatedSectionHeaderHeight = 0
        self.tableView?.estimatedRowHeight = 30
    }


    ///
    /// - Parameters:
    ///   - resultData: 完整的返回值(因为我要从里面取分页信息比如total)
    open func loadSuccess(resultData: Any?) {
        self.tableView?.showContent()
        self.pagingStrategy?.addPage(info: pagingList)
        let isFinish = (self.pagingStrategy?.checkFinish(result: resultData, listSize: pagingList.count)) ?? true
        self.tableView?.setLoadMoreEnable(b: !isFinish)
        self.tableView?.reloadData()
        if self.dataSource.isEmpty {
            self.tableView?.showEmpty()
        }
    }
    
    open func loadFail(_ error: Error? = nil){
        if(self.dataSource.count == 0) {
            self.tableView?.showError()
        } else {
            self.view.makeToast("加载失败")
        } 
        DDLogError(error?.localizedDescription ?? "")
    }

 

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(self.sectionData.count == 0) {
            return self.dataSource.count

        } else {
            return self.sectionData[section].count
        }
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.getRealDataSourceModel(indexPath: indexPath)
        let cellKey = String(describing: item.classForCoder.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellKey)
        let c = cell as! CellProtocol
        c.bindModel(item)
        self.registerEventforCell(cell: cell!, model: item)
        return cell!
    }

    ///子类重写去注册cell或者cell内部的事件
    open func registerEventforCell(cell: UITableViewCell, model: NSObject) { }


    ///子类重写去注册header或者header内部的事件
    open func registerEventforSectionHeader(header: UITableViewHeaderFooterView, model: NSObject) { }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if (section < self.sectionModelList.count) {
            let item = self.sectionModelList[section] as? NSObject ?? NSObject()
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: item.classForCoder.self))!
            let c = header as! CellProtocol
            c.bindModel(item)
            self.registerEventforSectionHeader(header: header, model: item)
            return header
        }
        return UIView()
    }


    open func numberOfSections(in tableView: UITableView) -> Int {

        self.sectionModelList = Array<NSObject>()
        let sectionCount = self.dataSource.filter { (data) -> Bool in
            let dataOjb = data as? NSObject ?? NSObject()
            let isSectionModel = (tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: dataOjb.classForCoder.self)) != nil)
            if(isSectionModel) {
                self.sectionModelList.append(data)
            }
            return isSectionModel
        }.count

        //没有section类型的model
        if sectionCount == 0 {
            sectionData.removeAll()
            return 1
        } else {
            self.sectionData.removeAll()
            var dataInSection: Array<NSObject>? = nil
            self.dataSource.forEach { (data) in
                let dataObj=data as? NSObject
                if(self.sectionModelList.contains(where: { (it) -> Bool in
                  return  dataObj == it as? NSObject
                })) {
                    if(dataInSection != nil) {
                        self.sectionData.append(dataInSection!)
                    }
                    dataInSection = Array<NSObject>()
                } else {
                    if(dataObj != nil){
                        dataInSection!.append(dataObj!)
                    }
                }
            }
            self.sectionData.append(dataInSection!)
        }
        return sectionCount
    }

    open override func start() {
        super.start()
        self.tableView?.beginRefresh()
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    public func getRealDataSourceModel(indexPath: IndexPath) -> NSObject {
        var sectionDataSource = Array<Any>()
        if(self.sectionData.count == 0) {
            sectionDataSource = self.dataSource
        } else {
            sectionDataSource = self.sectionData[indexPath.section]
        }
        let item = sectionDataSource[indexPath.row] as? NSObject ?? NSObject()
        return item
    }

    public func getDataSourceRowIndex(indexPath: IndexPath) -> Int {
        if(self.sectionData.count == 0) {
            return indexPath.row
        } else {
            var rowIndex = 0
            for i in 0..<indexPath.section {
                let sectionDataSource = self.sectionData[i]
                rowIndex += sectionDataSource.count
            }
            rowIndex += indexPath.section + 1;
            rowIndex += indexPath.row;
            return rowIndex
        }
    }

    ///禁止重写 因为你的indexpath用子类的datasource取到的不一定是真正的数据源,看下getRealDataSourceModel方法
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item: NSObject = self.getRealDataSourceModel(indexPath: indexPath)
        return self.tableView(tableView, heightForModel: item)
    }



    //默认使用autolayout方式
    //你可以重写
    open func tableView(_ tableView: UITableView, heightForModel model: NSObject) -> CGFloat {
        return UITableView.automaticDimension
    }

}
