//
//  HomeNavigationBar.swift
//  yinshijia
//
//  Created by Developer on 16/6/28.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class HomeNavigationBar: UIView {

    private var didUpdateConstraints = false
    private var searchBtn: UIButton!
    private var bellBtn: UIButton!
    private var leftItem: CustomButton!
    private var titleItem: UIImageView!
    private var searchDone: (()->())?
    private var bellDone: (()->())?
    private var cityChangeDone: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    convenience init(frame: CGRect, searchClick: ()->(), bellClick: ()->(), cityChange: ()->()) {
        self.init(frame: frame)
        searchDone = searchClick
        bellDone = bellClick
        cityChangeDone = cityChange
    }
    
    private func setUI() {
        searchBtn = UIButton(type: .Custom)
        searchBtn.setImage(UIImage(named: "homepage_search"), forState: .Normal)
        searchBtn.addTarget(self, action: "search", forControlEvents: .TouchUpInside)
        addSubview(searchBtn)
        
        bellBtn = UIButton(type: .Custom)
        bellBtn.setImage(UIImage(named: "homepage_bell"), forState: .Normal)
        bellBtn.addTarget(self, action: "bell", forControlEvents: .TouchUpInside)
        addSubview(bellBtn)
        
        leftItem = CustomButton(type: .Custom)
        leftItem.type = .ImgRight
        leftItem.margin = 4
        leftItem.setImage(UIImage(named: "city_arrow"), forState: .Normal)
        leftItem.setTitleColor(UIColor.colorFromHex(0x070707), forState: .Normal)
        leftItem.setTitle("成都", forState: .Normal)
        leftItem.titleLabel!.font = UIFont.systemFontOfSize(13)
        leftItem.addTarget(self, action: "cityChangeClick", forControlEvents: .TouchUpInside)
        addSubview(leftItem)

        titleItem = UIImageView(image: UIImage(named: "title_logo"))
        titleItem.sizeToFit()
        addSubview(titleItem)
        setNeedsUpdateConstraints()
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
    
    func cityChangeClick() {
        if cityChangeDone != nil {
            cityChangeDone!()
        }
    }

    override func updateConstraints() {
        if !didUpdateConstraints{
            searchBtn.autoAlignAxisToSuperviewAxis(.Horizontal)
            searchBtn.autoSetDimensionsToSize(CGSize(width: 30, height: 40))
            searchBtn.autoPinEdgeToSuperviewEdge(.Right, withInset: 17)

            bellBtn.autoSetDimensionsToSize(CGSize(width: 30, height: 40))
            bellBtn.autoAlignAxisToSuperviewAxis(.Horizontal)
            bellBtn.autoPinEdge(.Right, toEdge: .Left, ofView: searchBtn)
        
            titleItem.autoCenterInSuperview()
            
            leftItem.autoSetDimensionsToSize(CGSize(width: 60, height: 40))
            leftItem.autoAlignAxisToSuperviewAxis(.Horizontal)
            leftItem.autoPinEdgeToSuperviewEdge(.Left, withInset: 17)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
