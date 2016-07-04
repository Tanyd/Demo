//
//  MoreInfoCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit
protocol MoreInfoCellDelegate: NSObjectProtocol {
    func moreInfoCellDidChangeView(height: CGFloat)
}
class MoreInfoCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    private var menuTableH: CGFloat = 0
    private var envorViewH: CGFloat = 0
    weak var delegate: MoreInfoCellDelegate?
    var amenities = [Amenities]()
    var address: String?
    private lazy var buttonPage: BtnPageView = {
        let page = BtnPageView(frame:  CGRectZero, buttonTitles: ["菜单","环境","信息"])
        page.delegate = self
        return page
    }()
    
    private lazy var menuTable: MenuTable = {
        let menu = MenuTable(frame: CGRectZero, style: .Plain)
        menu.tag = 0
        return menu
    }()
    
    private lazy var environmentView: EnvironmentInfoView = {
        let view = EnvironmentInfoView(frame: CGRectZero)
        view.tag = 1
        return view
    }()
    
    private lazy var extInfoView: ExtInfoView = {
        let view = ExtInfoView(frame: CGRectZero)
        view.tag = 2
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(buttonPage)
        contentView.addSubview(menuTable)
        environmentView.hidden = true
        extInfoView.hidden = true
        setNeedsUpdateConstraints()
    }
    
    func configureModel(model: ChefDinner?) {
        if model?.data?.plainMenu?.count > 0 {
            var totalH: CGFloat = 0
            for menu in (model?.data?.plainMenu!)! {
                let titleH = (menu.title! as NSString).getTextRectSize(UIFont.systemFontOfSize(14), size: CGSize(width: ScreenSize.SCREEN_WIDTH, height: CGFloat.max)).height
                let despH = (menu.desp! as NSString).getTextRectSize(UIFont.systemFontOfSize(12), size: CGSize(width: ScreenSize.SCREEN_WIDTH, height: CGFloat.max)).height
                let cellH = titleH + despH + 25.0.fitHeight() + 60.0.fitHeight()
                totalH += cellH
            }
            menuTableH = totalH + 145.0.fitHeight()
            menuTable.plainMenus = (model?.data?.plainMenu!)!
        }
        
        if environmentView.enviromentModel != nil {return}
        if model?.data?.amenities?.count > 0 {
            let lines = (model?.data?.amenities?.count)! / 2 + (model?.data?.amenities?.count)! % 2
            let totalH = CGFloat(lines) * 40.0.fitHeight()
            if model?.data?.envImage?.count > 0 {
                envorViewH = 550.0.fitHeight() + totalH + 40.0.fitHeight() + 35.0.fitHeight() * 2.0
            }else{
                envorViewH = totalH + 40.0.fitHeight() + 35.0.fitHeight() * 2.0
            }
        }
        environmentView.enviromentModel = ((model?.data?.amenities),model?.data?.envImage)
        
        if extInfoView.extInfos.count > 0 {return}
        var tempArray = [[String]]()
        if model?.data?.baseInfo!.themeYinshijiaExtInfo?.count > 0 {
            var tempArr = [String]()
            tempArr.append((model?.data?.baseInfo?.themeYinshijiaExtInfo?[0])!)
            tempArr.append((model?.data?.baseInfo?.themeYinshijiaExtInfo?[1])!)
            tempArray.append(tempArr)
        }
        var tempArr = [String]()
        tempArr.append((model?.data?.baseInfo!.transportion_info)!)
        tempArr.append((model?.data?.baseInfo!.parking_info)!)
        tempArray.append(tempArr)
        extInfoView.extInfos = tempArray
    }
    
 
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            buttonPage.autoPinEdgeToSuperviewEdge(.Left, withInset: 30.0.fitWidth())
            buttonPage.autoPinEdgeToSuperviewEdge(.Right, withInset: 30.0.fitWidth())
            buttonPage.autoPinEdgeToSuperviewEdge(.Top)
            buttonPage.autoSetDimension(.Height, toSize: 100.0.fitHeight())
            didUpdateConstraints = true
        }
    
        if !menuTable.hidden {
            menuTable.autoPinEdge(.Top, toEdge: .Bottom, ofView: buttonPage, withOffset: 30.0.fitHeight())
            menuTable.autoPinEdge(.Left, toEdge: .Left, ofView: buttonPage)
            menuTable.autoPinEdge(.Right, toEdge: .Right, ofView: buttonPage)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: {
                menuTable.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            })
            
            menuTable.autoSetDimension(.Height, toSize: menuTableH)
        }
            
        if !environmentView.hidden {
            environmentView.autoPinEdge(.Top, toEdge: .Bottom, ofView: buttonPage, withOffset: 30.0.fitHeight())
            environmentView.autoPinEdge(.Left, toEdge: .Left, ofView: buttonPage)
            environmentView.autoPinEdge(.Right, toEdge: .Right, ofView: buttonPage)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: {
                environmentView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            })
            environmentView.autoSetDimension(.Height, toSize: envorViewH)
        }
        
        if !extInfoView.hidden {
            extInfoView.autoPinEdge(.Top, toEdge: .Bottom, ofView: buttonPage)
            extInfoView.autoPinEdge(.Left, toEdge: .Left, ofView: buttonPage)
            extInfoView.autoPinEdge(.Right, toEdge: .Right, ofView: buttonPage)
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: {
                extInfoView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30.0.fitHeight())
            })
            extInfoView.autoSetDimension(.Height, toSize: 450.0.fitHeight())
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

extension MoreInfoCell: BtnPageViewDelegate {
    func btnPageViewDidTouchButton(fromIndex: Int, toIndex: Int) {
        if toIndex == 0{
            contentView.addSubview(menuTable)
            menuTable.hidden = false
            environmentView.removeFromSuperview()
            environmentView.hidden = true
            extInfoView.removeFromSuperview()
            extInfoView.hidden = true
        }else if toIndex == 1 {
            contentView.addSubview(environmentView)
            environmentView.hidden = false
            menuTable.removeFromSuperview()
            menuTable.hidden = true
            extInfoView.removeFromSuperview()
            extInfoView.hidden = true
        }else if toIndex == 2{
            contentView.addSubview(extInfoView)
            extInfoView.hidden = false
            menuTable.removeFromSuperview()
            menuTable.hidden = true
            environmentView.removeFromSuperview()
            environmentView.hidden = true
        }
       
        updateConstraints()
        let c = contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        if delegate != nil && (delegate?.respondsToSelector("moreInfoCellDidChangeView:"))! {
            delegate?.moreInfoCellDidChangeView(c)
        }
    }
}
