//
//  ChefInoMarksCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class ChefInfoMarksCell: UITableViewCell {

    private var didUpdateConstraints = false
    private var marksH: CGFloat = 0
    private var tags = [String]() {
        didSet{
            marksView.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(marksView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var marksView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.registerClass(MarksCollectionCell.self, forCellWithReuseIdentifier: String(MarksCollectionCell))
        view.backgroundColor = UIColor.whiteColor()
        view.delegate = self
        view.dataSource = self
        view.scrollEnabled = false
        return view
    }()
    
    func configureModel(model: String?) {
        if marksView.subviews.count > 0 {return}
        if model?.length() > 0 {
            marksH = 100.0.fitHeight()
            let temp = (model! as NSString).componentsSeparatedByString(",")
            var tempW: CGFloat = 0
            for tag in temp {
                let tempSize = (tag as NSString).getTextRectSize(UIFont.systemFontOfSize(11), size: CGSize(width: CGFloat.max,height: CGFloat.max))
                tempW += tempSize.size.width
            }
            let countLine = ceil((tempW + 30.0.fitWidth() * CGFloat(temp.count - 1)) / (ScreenSize.SCREEN_WIDTH - 60.0.fitWidth()))
            marksH = 100.0.fitHeight() * countLine + (countLine - 1) * 20.0.fitHeight()
            tags = temp
        }else{
            marksH = 0
        }
    }

    override func updateConstraints() {
        if !didUpdateConstraints{
            marksView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: { 
                marksView.autoPinEdgeToSuperviewEdge(.Bottom)
            })
            marksView.autoSetDimension(.Height, toSize: marksH)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ChefInfoMarksCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(MarksCollectionCell), forIndexPath: indexPath) as? MarksCollectionCell
        cell!.tagStr = tags[indexPath.item]
        return cell!
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let tag = tags[indexPath.item]
        let tagSize = (tag as NSString).getTextRectSize(UIFont.systemFontOfSize(11), size: CGSize(width: CGFloat.max,height: CGFloat.max))
        return CGSize(width: tagSize.width + 30.0.fitWidth(), height: 40.0.fitHeight())
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0.fitHeight()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(30.0.fitHeight(), 30.0.fitWidth(), 30.0.fitHeight(), 30.0.fitWidth())
    }

}

