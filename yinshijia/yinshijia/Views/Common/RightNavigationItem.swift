//
//  RightNavigationItem.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class RightNavigationItem: UIView {
    
    private var searchDone: (()->())?
    private var bellDone: (()->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    convenience init(frame: CGRect,searchClick: ()->(),bellClick: ()->()) {
        self.init(frame:frame)
        searchDone = searchClick
        bellDone = bellClick
    }

    private func setUI() {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: "homepage_search"), forState: .Normal)
        btn.addTarget(self, action: "search", forControlEvents: .TouchUpInside)
        addSubview(btn)
        let btn1 = UIButton(type: .Custom)
        btn1.setImage(UIImage(named: "homepage_bell"), forState: .Normal)
        btn1.addTarget(self, action: "bell", forControlEvents: .TouchUpInside)
        addSubview(btn1)
    }
    
    func search() {
        if searchDone != nil {
            searchDone!()
        }
    }
    
    func bell() {
        if bellDone != nil {
            bellDone!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for var index = 0; index < subviews.count; index++ {
            let btn = subviews[index]
            btn.frame = CGRectMake(width * 0.5 * CGFloat(index), 0, width * 0.5, height)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
