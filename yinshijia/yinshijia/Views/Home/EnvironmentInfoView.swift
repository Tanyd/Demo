//
//  EnvironmentInfoView.swift
//  yinshijia
//
//  Created by Developer on 16/6/20.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class EnvironmentInfoView: UIView {
    
    var enviromentModel:([Amenities]?,[Envimage]?)?{
        didSet{
            setUI()
        }
    }
    
    private lazy var topImg: UIImageView = {
        let img = UIImageView()
        img.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(EnvironmentInfoView.environmentImageDidClick(_:)))
        img.addGestureRecognizer(tap)
       return img
    }()
    
    private var allBtns = [UIButton]()
    
    private var countView: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 17.0.fitWidth(), bottom: 0, right: 0)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "menu_count_icon"), forState: .Normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topImg)
    }

    private func setUI() {
        topImg.sd_setImageWithURL(NSURL(string: (enviromentModel?.1?.first?.image)!)!)
        
        if enviromentModel?.1?.count > 1 {
            countView.setTitle(String(enviromentModel!.1!.count), forState: .Normal)
            addSubview(countView)
        }
        
        for index in 0...(enviromentModel?.0!.count)! - 1 {
            let btn = UIButton(type: .Custom)
            btn.titleLabel?.font = UIFont.systemFontOfSize(12)
            btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
            btn.setTitle(enviromentModel?.0![index].name, forState: .Normal)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30.0.fitWidth(), bottom: 0, right: 0)
            btn.setImage(UIImage(named: "amentity_unavailable"), forState: .Normal)
            btn.setImage(UIImage(named: "amentity_available"), forState: .Selected)
            btn.contentHorizontalAlignment = .Left
            if enviromentModel?.0![index].isBool == 0 {
                btn.selected = false
            }else{
                btn.selected = true
            }
            btn.tag = index
            allBtns.append(btn)
            addSubview(btn)
        }
    }
    
    func environmentImageDidClick(tap: UITapGestureRecognizer) {
        var photosUrl = [String]()
        for model in (enviromentModel?.1)! {
            photosUrl.append(model.image!)
        }
        let browser = IDMPhotoBrowser(photoURLs: photosUrl)
        browser.displayCounterLabel = true
        browser.displayActionButton = false
//        browser.doneButtonImage = UIImage(named: "circle_delete_icon")
        UIApplication.sharedApplication().windows.last?.rootViewController?.presentViewController(browser, animated: true, completion: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topImg.frame = CGRectMake(0, 40.0.fitHeight(), width, 550.0.fitHeight())
        if enviromentModel?.1?.count > 1 {
            countView.frame = CGRectMake(CGRectGetMaxX(topImg.frame) - 15.0.fitWidth() - (countView.currentBackgroundImage?.size.width)!, CGRectGetMaxY(topImg.frame) - 15.0.fitHeight() - (countView.currentBackgroundImage?.size.height)!, (countView.currentBackgroundImage?.size.width)!, (countView.currentBackgroundImage?.size.height)!)
        }
        var x: CGFloat = 0
        var y: CGFloat = 0
        let btnWidth = 315.0.fitWidth()
        let btnHeight = 50.0.fitHeight()
        let constantY = 35.0.fitHeight()
        for index in 0...allBtns.count - 1 {
            let btn = allBtns[index]
            x = constantY + CGFloat(index % 2) * btnWidth
            y = constantY + CGFloat(Int(index / 2) * Int(btnHeight)) + 550.0.fitHeight() + constantY
            btn.frame = CGRectMake(x, y, btnWidth, btnHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
