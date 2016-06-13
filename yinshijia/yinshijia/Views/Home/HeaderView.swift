//
//  HeaderView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    private var banner: BannerView!
    private var categoryView: CategoryView!
    var categorys = [Catalog](){
        didSet{
            categoryView.categorys = categorys
        }
    }
    var banners = [Banner](){
        didSet{
            var imgs = [String]()
            for img in banners {
                if let imgUrl = img.banner_image {
                    imgs.append(imgUrl)
                }
            }
            banner.imgUrls = imgs
        }
    }
    private let bannerHeight = 350.0.fitHeight()
    private let categoryHeight = 190.0.fitHeight()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        banner = BannerView(frame: CGRectZero)
        addSubview(banner)
        categoryView = CategoryView(frame: CGRectZero)
        addSubview(categoryView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banner.frame = CGRectMake(0, 0, width, bannerHeight)
        categoryView.frame = CGRectMake(0, bannerHeight, width, categoryHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class CategoryView: UIScrollView {
    
    private var views = [marginView]()
    private var categorys = [Catalog](){
        didSet{
            setUI()
            layoutIfNeeded()
        }
    }
    private let btnWidth = 180.0.fitWidth()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: 不要每次刷新都创建，能重用就重用
    private func setUI() {
        if views.count > 0 {
            views.removeAll()
            for view in views {
                view.removeFromSuperview()
            }
        }
        for var index = 0; index < categorys.count; index++ {
            let model = categorys[index]
            let view = marginView(frame: CGRectZero)
            view.catalog = categorys[index]
            addSubview(view)
            views.append(view)
        }
        contentSize = CGSize(width: btnWidth * CGFloat(views.count), height: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for var index = 0; index < views.count; index++ {
            let view = views[index]
            view.frame = CGRect(x: CGFloat(index) * btnWidth, y: 0, width: btnWidth, height: height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class marginView: UIView {
    
    private var btn: UIButton!
    private var marginTop = 19.0.fitHeight()
    private var marginLeft = 13.0.fitWidth()
    private let btnWidth = 180.0.fitWidth()

    var catalog: Catalog?{
        didSet{
            btn.setTitle(catalog!.catalogTitle, forState: .Normal)
            btn.sd_setBackgroundImageWithURL(NSURL(string: catalog!.catalogImage!), forState: .Normal)
            btn.tag = catalog!.catalogId
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        btn = UIButton(type: .Custom)
        btn.userInteractionEnabled = false
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont(name: Constant.Common.BoldFont, size: 10)
        btn.sizeToFit()
        addSubview(btn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x: marginLeft, y: marginTop, width: btnWidth - 2 * marginLeft, height: height - 2 * marginTop)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


