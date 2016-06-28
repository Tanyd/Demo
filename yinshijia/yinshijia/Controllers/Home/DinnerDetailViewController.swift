//
//  DinnerDetailViewController.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/18.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class DinnerDetailViewController: BaseViewController {

    private var dinnerTable: DinnerDetailTableView!
    var chefDinnerID: Int?{
        didSet{
            loadBaseDate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviagtionBarAppearance()
        setUI()
    }
    
    private func loadBaseDate() {
        let callBack: BaseApiCallBack = {[weak self](result, error) in
            guard error == nil else {
                return
            }
            self!.dinnerTable.model = result as? ChefDinner
        }
        ChefDinner.loadDetailDinner(callBack, id: chefDinnerID!)
    }
    
    private func setNaviagtionBarAppearance() {
        automaticallyAdjustsScrollViewInsets = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        let collect = UIButton(type: UIButtonType.Custom)
        collect.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        collect.setImage(UIImage(named: "rejuSave"), forState: .Normal)
        let share = UIButton(type: UIButtonType.Custom)
        share.frame = CGRect(x: 10 + 30, y: 0, width: 30, height: 30)
        share.setImage(UIImage(named: "rejuShare"), forState: .Normal)
        title = "dddddddd"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: share),UIBarButtonItem(customView: collect)]
    }
    
    private func setUI() {
        dinnerTable = DinnerDetailTableView(frame: view.bounds, style: .Plain)
        view.addSubview(dinnerTable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}
