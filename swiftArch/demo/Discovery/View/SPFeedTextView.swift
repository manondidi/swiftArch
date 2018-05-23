//
//  SPTextView.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

/// 用于处理显示内容
class SPFeedTextView: UITextView {
    
    static var CoverTag:Int = 999
    
    var specials : [TextSpecial] = [TextSpecial]()
    
    
    // MARK:- UIView(UIViewGeometry)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var isInside = super.point(inside: point, with: event)
        
        if isInside {
            // 判断是否点击了特殊内容
            isInside = self.judgeTouchSpecial(point: point)
        }
        
//        print("point inside \(point) isInside=\(isInside)")
        return isInside
    }
    
    // MARK:- UIResponder
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan==")
        let touch = touches.first
        if let point = touch?.location(in: self) {
            let _ = self.judgeTouchSpecial(point: point, setCover: true)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesEnded==")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.touchesCancelled(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan==")
        for child in self.subviews {
            if child.tag == SPFeedTextView.CoverTag {
                child.removeFromSuperview()
            }
        }
    }
    
    // MARK:- Helper
    
    private func judgeTouchSpecial(point: CGPoint, setCover: Bool = false) -> Bool {
        var found = false
        for special in specials {
            self.selectedRange = special.range
            let selectionRects = self.selectionRects(for: self.selectedTextRange!) as! [UITextSelectionRect]
            self.selectedRange = NSRange.init()
            
            for selectionRect in selectionRects {
                let rect = selectionRect.rect
                if rect.size.width == 0 || rect.size.height == 0 {
                    continue
                }
                if rect.contains(point) {
                    found = true
                    break
                }
            }
            
            if found && setCover {
                for selectionRect in selectionRects {
                    let rect = selectionRect.rect
                    if rect.size.width == 0 || rect.size.height == 0 {
                        continue
                    }
                    let cover = UIView()
                    cover.backgroundColor = UIColor.cyan
                    cover.frame = rect
                    cover.tag = SPFeedTextView.CoverTag
                    cover.layer.cornerRadius = 3
                    self.insertSubview(cover, at: 0)
                }
                break
            }
        }
        return found
    }
}
