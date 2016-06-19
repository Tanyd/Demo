//
//  MoreInfoCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/19.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class MoreInfoCell: UITableViewCell {

    private lazy var buttonPage: BtnPageView = {
        let page = BtnPageView(frame:  CGRectZero, buttonTitles: ["精选","主厨","推荐"])
        return page
    }()
    
    private lazy var menuTable: MenuTable = {
        let menu = MenuTable(frame: CGRectZero, style: .Plain)
        menu.dataSource = self
        menu.delegate = self
        return menu
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension MoreInfoCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>)
    }
}
