//
//  MarksCollectionCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MarksCollectionCell: UICollectionViewCell {
    
    private var didUpdateConstraints = false

    var tagStr: String? {
        didSet{
            marksLabel.text = tagStr
        }
    }
    
    private lazy var marksLabel: UILabel = {
        let label = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.whiteColor(), fontSize: 11)
        label.backgroundColor = UIColor.grayColor()
        label.layer.cornerRadius = 10
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(marksLabel)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            marksLabel.autoPinEdgesToSuperviewEdges()
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
