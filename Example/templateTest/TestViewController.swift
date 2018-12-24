//
//  TestViewController.swift
//  swiftArch_Example
//
//  Created by czq on 2018/12/24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import swiftArch
import RxSwift

class TestViewController: PagingTableViewController { 
  
 	override func initView() {
        super.initView() 

    }


    override func registerSectionHeaderModel(){
        super.registerSectionHeaderModel() 

    }

    override func registerCellModel() {
        super.registerCellModel()
//        self.tableView?.registerCellNib(nib: <#T##UINib#>, modelClass: <#T##AnyClass#>)
//        self.tableView?.registerCellClass(cellClass: <#T##AnyClass#>, modelClass: <#T##AnyClass#>)

    }


    override func registerEventforCell(cell: UITableViewCell, model: NSObject) {
        
    }
 
  
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy? { 


        return nil
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy?) {
        
       
        
    }
     
}

