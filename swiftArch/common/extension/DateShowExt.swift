//
//  DateShowExt.swift
//  swiftArch
//
//  Created by aron on 2018/5/22.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation

extension Date {
    func friendlyDateString() -> String {
        let curDate = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: curDate)
        if self.isThisYear() {
            if let day = components.day {
                if day > 1 {
                    // 昨天之前
                    return Date.yestodayBeforFormatter.string(from: self)
                } else if components.day == 1 {
                    // 昨天
                    return Date.yestodayFormatter.string(from: self)
                } else {
                    // 今天
                    if components.hour! > 1 {
                        return "\(components.hour!)小时前"
                    } else if components.minute! > 1 {
                        return "\(components.minute!)分钟前"
                    } else {
                        return "刚刚"
                    }
                }
            } else {
                return Date.postDateFormatter.string(from: self)
            }
        } else {
            // 去年
            return Date.postDateFormatter.string(from: self)
        }
    }
    
    func isThisYear() -> Bool {
        let dateComp = Calendar.current.dateComponents([.year], from: self)
        let nowComp = Calendar.current.dateComponents([.year], from: Date())
        return nowComp.year == dateComp.year
    }
    
    static let postDateFormatter: DateFormatter = {
        var postDateFormatter = DateFormatter()
        postDateFormatter.dateFormat = " YYYY-MM-dd HH:mm"
        return postDateFormatter
    }()
    
    static let yMdFormatter: DateFormatter = {
        var yMdFormatter = DateFormatter()
        yMdFormatter.dateFormat = " yyyy-MM-dd"
        return yMdFormatter
    }()
    
    static let yestodayBeforFormatter: DateFormatter = {
        var yMdFormatter = DateFormatter()
        yMdFormatter.dateFormat = " MM-dd HH:mm"
        return yMdFormatter
    }()
    
    static let yestodayFormatter: DateFormatter = {
        var yMdFormatter = DateFormatter()
        yMdFormatter.dateFormat = "昨天 HH:mm"
        return yMdFormatter
    }()
}
