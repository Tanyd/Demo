//
//  HistoryDinnerCell.swift
//  yinshijia
//
//  Created by Developer on 16/7/7.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class HistoryDinnerCell: UITableViewCell {

    private var didUpdateConstraints = false
    private var historyCollectionViewH: CGFloat = 0
    var historyDinners = [Historydinner]()
    var historyCusDinners = [Historycustommadedinner]()
    
    private lazy var historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.registerClass(HistoryDinnerCollectionViewCell.self, forCellWithReuseIdentifier: String(HistoryDinnerCollectionViewCell))
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(historyCollectionView)
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefInfo?) {
        if model?.data?.historyDinner?.count > 0 {
            historyDinners = (model?.data?.historyDinner)!
        }
        if model?.data?.historyCustomMadeDinner?.count > 0 {
            historyCusDinners = (model?.data?.historyCustomMadeDinner)!
        }
        if historyDinners.count > 0 || historyCusDinners.count > 0 {
            historyCollectionViewH = 330.0.fitHeight()
        }
        historyCollectionView.reloadData()
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints{
            historyCollectionView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 30.0.fitWidth(), bottom: 0, right: 30.0.fitWidth()))
            historyCollectionView.autoSetDimension(.Height, toSize: historyCollectionViewH)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension HistoryDinnerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyDinners.count + historyCusDinners.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(HistoryDinnerCollectionViewCell), forIndexPath: indexPath) as? HistoryDinnerCollectionViewCell
        if historyCusDinners.count > 0 && historyDinners.count > 0 {
            if indexPath.row > historyDinners.count - 1 {
                cell?.historyCusDinner = historyCusDinners[indexPath.row - historyDinners.count]
            }else{
                cell?.historyDinner = historyDinners[indexPath.row]
            }
        }else if historyDinners.count > 0 && historyCusDinners.count == 0 {
            cell?.historyDinner = historyDinners[indexPath.row]
        }else if historyDinners.count == 0 && historyCusDinners.count > 0 {
            cell?.historyCusDinner = historyCusDinners[indexPath.row]
        }
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 192.0.fitWidth(), height: 313.0.fitHeight())
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 30.0.fitWidth()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
}
