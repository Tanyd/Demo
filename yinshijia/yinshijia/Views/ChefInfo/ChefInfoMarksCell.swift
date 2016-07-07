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
    private var marksConstraint: NSLayoutConstraint!
    private var tags = [String]() {
        didSet{
            marksView.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(marksView)
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
        view.delegate = self
        view.dataSource = self
        view.scrollEnabled = false
        return view
    }()
    
    func configureModel(model: String?) {
        if marksView.subviews.count > 0 {return}
        if model?.length() > 0 {
            marksH = 40.0.fitHeight()
            tags = (model! as NSString).componentsSeparatedByString(",")
        }else{
            marksH = 0
        }
    }

    override func updateConstraints() {
        if !didUpdateConstraints{
            marksView.autoPinEdgesToSuperviewEdges()
            marksConstraint = marksView.autoSetDimension(.Height, toSize: marksH)
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
        return CGSize(width: tagSize.width + 10.0.fitWidth(), height: 40.0.fitHeight())
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0.fitWidth()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0.fitWidth()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(30.0.fitHeight(), 30.0.fitWidth(), 30.0.fitHeight(), 30.0.fitWidth())
    }

}

