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
    
    private func setUI() {
        dinnerTable = DinnerDetailTableView(frame: view.bounds, style: .Plain)
        view.addSubview(dinnerTable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}
