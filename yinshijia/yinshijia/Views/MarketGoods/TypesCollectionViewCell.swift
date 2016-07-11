//
//  TypesCollectionViewCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class TypesCollectionViewCell: UICollectionViewCell {
    
    private var didUpdateConstraints = false
    var type: String?{
        didSet{
            typeLabel.text = type
        }
    }
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.blackColor(), fontSize: 15)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.colorFromHex(0xf5f5f5)
        label.layer.cornerRadius = 5.0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(typeLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            typeLabel.autoPinEdgeToSuperviewEdge(.Left)
            typeLabel.autoPinEdgeToSuperviewEdge(.Right)
            typeLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 20.0.fitHeight())
            typeLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 20.0.fitHeight())
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
}
