//
//  AddressInfoView.swift
//  yinshijia
//
//  Created by Developer on 16/6/20.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class AddressInfoCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    
    var addressModel: (String,String)?{
        didSet{
            addressButton.setTitle(addressModel?.0, forState: .Normal)
            mapView.sd_setImageWithURL(NSURL(string: (addressModel?.1)!), placeholderImage: nil)
        }
    }
    
    private lazy var titleLable: UILabel = {
        let title = UILabel.labelCustomer("饭局地址", fontType: nil, color: UIColor.blackColor(), fontSize: 17)
        title.textAlignment = .Center
        return title
    }()
    
    private lazy var mapView: UIImageView = {
        let map = UIImageView()
        map.contentMode = .ScaleAspectFill
        map.clipsToBounds = true
        return map
    }()
    
    private lazy var addressButton: UIButton = {
        let address = UIButton(type: .Custom)
        address.userInteractionEnabled = false
        address.contentHorizontalAlignment = .Left
        address.setImage(UIImage(named: "choose_location"), forState: .Normal)
        address.titleEdgeInsets = UIEdgeInsetsMake(0, 30.0.fitWidth(), 0, 0)
        address.userInteractionEnabled = false
        address.setTitleColor(UIColor.grayColor(), forState: .Normal)
        address.titleLabel?.font = UIFont.systemFontOfSize(12)
        return address
    }()
    
    private lazy var moreArrow: UIImageView = {
        let more = UIImageView(image: UIImage(named: "more_arrow"))
        return more
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(mapView)
        contentView.addSubview(addressButton)
        addressButton.addSubview(moreArrow)
        setNeedsUpdateConstraints()
    }
  
    func configureModel(address: String?,mapUrl: String?){
        if address != nil {
            addressButton.setTitle(address!, forState: .Normal)
        }
        
        if mapUrl != nil {
            mapView.sd_setImageWithURL(NSURL(string: mapUrl!), placeholderImage: nil)
        }
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            titleLable.autoAlignAxisToSuperviewAxis(.Vertical)
            titleLable.autoPinEdgeToSuperviewEdge(.Top, withInset: 60.0.fitHeight())
            
            mapView.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            mapView.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            mapView.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLable, withOffset: 45.0.fitHeight())
            mapView.autoSetDimension(.Height, toSize: 305.0.fitHeight())
            
            addressButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: mapView, withOffset: 30.0.fitHeight())
            addressButton.autoPinEdge(.Left, toEdge: .Left, ofView: mapView)
            addressButton.autoPinEdge(.Right, toEdge: .Right, ofView: mapView)
            addressButton.autoSetDimension(.Height, toSize: 100.0.fitHeight())
            addressButton.autoPinEdgeToSuperviewEdge(.Bottom)
            
            moreArrow.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            moreArrow.autoAlignAxisToSuperviewAxis(.Horizontal)
            moreArrow.autoSetDimension(.Width, toSize: 30.0.fitWidth())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
