//
//  AddressInfoView.swift
//  yinshijia
//
//  Created by Developer on 16/6/20.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class AddressInfoView: UIView {
    
    private var didUpdateConstraints = false

    private lazy var titleLable: UILabel = {
        let title = UILabel.lableCutomer("饭局地址", fontType: nil, color: UIColor.blackColor(), fontSize: 17)
        title.textAlignment = .Center
        return title
    }()
    
    private lazy var mapView: UIImageView = {
        let map = UIImageView()
        map.backgroundColor = UIColor.redColor()
        return map
    }()
    
    private lazy var addressButton: UIButton = {
        let address = UIButton(type: .Custom)
        address.setImage(UIImage(named: "choose_location"), forState: .Normal)
        address.titleEdgeInsets = UIEdgeInsetsMake(0, 30.0.fitWidth(), 0, 0)
        address.userInteractionEnabled = false
        return address
    }()
    
    private lazy var moreButton: UIButton = {
        let more = UIButton(type: .Custom)
        more.setBackgroundImage(UIImage(named: "more_arrow"), forState: .Normal)
        more.userInteractionEnabled = false
        return more
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLable)
        addSubview(mapView)
        addSubview(addressButton)
        addSubview(moreButton)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoAlignAxisToSuperviewAxis(.Vertical)
            titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            mapView.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            mapView.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            mapView.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 45.0.fitHeight())
            mapView.autoSetDimension(.Height, toSize: 275.0.fitHeight())
            
            addressButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: mapView, withOffset: 30.0.fitHeight())
            addressButton.autoPinEdge(.Left, toEdge: .Left, ofView: mapView)
            addressButton.autoPinEdge(.Right, toEdge: .Right, ofView: mapView)
            addressButton.autoSetDimension(.Height, toSize: 100.0.fitHeight())
            addressButton.autoPinEdgeToSuperviewEdge(.Bottom)
            
            moreButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            moreButton.autoPinEdge(.Top, toEdge: .Top, ofView: addressButton)
            moreButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: addressButton)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
