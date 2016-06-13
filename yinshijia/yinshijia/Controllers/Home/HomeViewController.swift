//
//  HomeViewController.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

   
    private var currentViewIndex = 0
    private let titleViewHeight = 64
    private var didScroll = false
    private var didOriginal = true
    private var choicePage = 0
    private let choiceMaxPage = 5
    private var pageVC: PageViewController!
    private var titleView: BtnPageView!
    private var allChildsVC = [UIViewController]()
    private var toTopIcon: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        setUI()
        addNotification()

    }
    
    private func setNavigationItems() {
       
        let rightView = RightNavigationItem(frame: CGRect(x: 0, y: 0, width: 60, height: 40), searchClick: {
            DebugPrint("search")
            }) { 
                DebugPrint("bell")
        }
        
        let leftItem = LeftImgButton(type: .Custom)
        leftItem.setImage(UIImage(named: "city_arrow"), forState: .Normal)
        leftItem.setTitleColor(UIColor.colorFromHex(0x070707), forState: .Normal)
        leftItem.setTitle("成都", forState: .Normal)
        leftItem.titleLabel!.font = UIFont.systemFontOfSize(13)
        leftItem.addTarget(self, action: "cityChangeClick", forControlEvents: .TouchUpInside)
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spacer.width = -10
        navigationItem.rightBarButtonItems = [spacer, UIBarButtonItem(customView: rightView)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
        navigationItem.titleView = UIImageView(image: UIImage(named: "title_logo"))
    }
    
    func cityChangeClick() {
        DebugPrint("changeCity")
    }
    
    private func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeUI:", name: BaseTranslationViewControllerNotification.NotificationName, object: nil)
    }
    
    private func setUI() {
        titleView = BtnPageView(frame: CGRect(x: 0, y: 64, width: Int(ScreenSize.SCREEN_WIDTH), height: titleViewHeight))
        titleView.delegate = self
        view.addSubview(titleView)
        
        pageVC = PageViewController()
        pageVC.dataSource = self
        pageVC.delegate = self
        addChildViewController(pageVC)
        pageVC.view.frame = CGRect(x: 0, y: 64 + titleViewHeight, width: Int(ScreenSize.SCREEN_WIDTH), height: Int(ScreenSize.SCREEN_HEIGHT) - titleViewHeight)
        view.addSubview(pageVC.view)

        toTopIcon = UIButton(type: .Custom)
        toTopIcon.frame = CGRect(x: ScreenSize.SCREEN_WIDTH - 170.0.fitWidth(), y: ScreenSize.SCREEN_HEIGHT - 100.0.fitHeight(), width: 180.0.fitWidth(), height: 80.0.fitWidth())
        toTopIcon.setBackgroundImage(UIImage(named: "backToTop"), forState: .Normal)
        toTopIcon.addTarget(self, action: "toTop", forControlEvents: .TouchUpInside)
        toTopIcon.sizeToFit()
        view.addSubview(toTopIcon)
        view.setNeedsUpdateConstraints()
        
    }
    
    func toTop() {
        UIView.animateWithDuration(0.3) { 
            self.translationDown()
            
            switch self.currentViewIndex {
            case 0:
                let vc = self.allChildsVC[self.currentViewIndex] as! ChoiceViewController
                vc.tableView.contentOffset = CGPointZero
            case 1:
                let vc = self.allChildsVC[self.currentViewIndex] as! TranslationCollectionViewController
                vc.collectionView!.contentOffset = CGPointZero
            case 2:
                break
            default:
                break
            }
        }
    }
    
    
    func changeUI(notif: NSNotification) {
        
        let offY = notif.userInfo![BaseTranslationViewControllerNotification.CurrentOffY] as! CGFloat
        let oldY = notif.userInfo![BaseTranslationViewControllerNotification.OldOffY] as! CGFloat
        if offY > oldY && !didScroll { // up
            UIView.animateWithDuration(0.3, animations: { 
                self.translationUp()
            })
        }else if offY < oldY && !didOriginal { // down
            UIView.animateWithDuration(0.3, animations: {
                self.translationDown()
            })
        }
    }
    
    
    private func translationUp() {
        tabBarController?.tabBar.transform = CGAffineTransformMakeTranslation(0, 70)
        navigationController?.navigationBar.transform = CGAffineTransformMakeTranslation(0, -64)
        pageVC.view.transform = CGAffineTransformMakeTranslation(0, -64)
        titleView.transform = CGAffineTransformMakeTranslation(0, -64)
        toTopIcon.transform = CGAffineTransformMakeTranslation(0, -64)
        didScroll = true
        didOriginal = false
    }
    
    private func translationDown() {
        tabBarController?.tabBar.transform = CGAffineTransformIdentity
        navigationController?.navigationBar.transform = CGAffineTransformIdentity
        pageVC.view.transform = CGAffineTransformIdentity
        titleView.transform = CGAffineTransformIdentity
        toTopIcon.transform = CGAffineTransformIdentity
        didScroll = false
        didOriginal = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension HomeViewController: PageViewControllerDataSource, PageViewControllerDelegate, BtnPageViewDelegate {
    
    func childControllersInPageView(pageView: PageViewController) -> [UIViewController] {
        
        let vc1 = ChoiceViewController()
        allChildsVC.append(vc1)
        vc1.view.tag = 0
//        vc1.view.backgroundColor = UIColor.redColor()
        let layout = UICollectionViewLayout()
        let vc2 = ChefViewController()
        allChildsVC.append(vc2)
        vc2.view.tag = 1
        
        let vc3 = MarketViewController()
        allChildsVC.append(vc3)
        vc3.view.tag = 2
        vc3.view.backgroundColor = UIColor.blueColor()
        
        return [vc1,vc2,vc3]
    }
    
    func pageViewExchangeView(fromIndex: Int, toIndex: Int) {
        titleView.exchangeSelectedButton(fromIndex, toIndex: toIndex)
        currentViewIndex = toIndex
    }

    
    func btnPageViewDidTouchButton(fromIndex: Int, toIndex: Int) {
        pageVC.exchangeChildView(fromIndex, toIndex: toIndex)
        currentViewIndex = toIndex
    }
    
    
}


