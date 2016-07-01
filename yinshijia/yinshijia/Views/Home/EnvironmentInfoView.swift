//
//  EnvironmentInfoView.swift
//  yinshijia
//
//  Created by Developer on 16/6/20.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class EnvironmentInfoView: UIView {

    var amenities = [Amenities](){
        didSet{
//            setUI()
        }
    }
    
    var enviromentModel:([Amenities]?,[Envimage]?)?{
        didSet{
            setUI()
        }
    }
    
    private lazy var topImg: UIImageView = {
       return UIImageView()
    }()
    
    private var allBtns = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topImg)
    }

    private func setUI() {
        topImg.sd_setImageWithURL(NSURL(string: (enviromentModel?.1?.first?.image)!)!)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topImg.frame = CGRectMake(0, 40.0.fitHeight(), width, 550.0.fitHeight())
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
