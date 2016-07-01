//
//  DinnerDetailTableView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DinnerDetailTableView: UITableView {

    private var banner: BannerView?
    var model: ChefDinner?{
        didSet{
            banner?.imgs = (model?.data?.baseInfo?.theme_images?.componentsSeparatedByString(","))!
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    private func setUI(){
        banner = BannerView(frame: CGRectMake(0, -64, ScreenSize.SCREEN_WIDTH, 600.0.fitHeight()), focusImageViewClick: { (index) in
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
