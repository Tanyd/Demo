//
//  BannerView.swift
//  yinshijia
//
//  Created by tanyadong on 16/6/11.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class BannerView: UIView {
    
    private var didUpdateConstraints = false
    
    private let imageViewMaxCount = 3
    
    private var imageScrollView: UIScrollView!
    
    private var pageControl: UIPageControl!
    
    private var timer: NSTimer?
    
    private var allImgs = [BannerImageView]()
    
    var bannerImageClick:((index: Int) -> ())?
    
    var choiceBanner = [Banner]() {
        didSet{
            
            if ((timer?.valid) != nil) {
                timer?.invalidate()
                timer = nil
            }
            
            if choiceBanner.count > 0 {
                pageControl.numberOfPages = (choiceBanner.count)
                pageControl.currentPage = 0
                updatePageScrollView()
                startTimer()
            }
        }
    }
    
    var chefBanner = [ChefBanner]() {
        didSet{
            if ((timer?.valid) != nil) {
                timer?.invalidate()
                timer = nil
            }
            
            if chefBanner.count > 0 {
                pageControl.numberOfPages = (chefBanner.count)
                pageControl.currentPage = 0
                updatePageScrollView()
                startTimer()
            }
        }

    }
    
    var imgs = [String]() {
        didSet{
            if ((timer?.valid) != nil) {
                timer?.invalidate()
                timer = nil
            }
            
            if imgs.count > 0 {
                pageControl.numberOfPages = (imgs.count)
                pageControl.currentPage = 0
                updatePageScrollView()
                startTimer()
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    convenience init(frame: CGRect, focusImageViewClick:((index: Int) -> Void)) {
        self.init(frame: frame)
        bannerImageClick = focusImageViewClick
    }
    
    private func setUI() {
        imageScrollView = UIScrollView.newAutoLayoutView()
        imageScrollView.bounces = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.pagingEnabled = true
        imageScrollView.delegate = self
        imageScrollView.contentSize = CGSizeMake(CGFloat(imageViewMaxCount) * ScreenSize.SCREEN_WIDTH, 0)
        addSubview(imageScrollView)
        
        for _ in 0..<imageViewMaxCount {
            let imageView = BannerImageView(frame: CGRectZero)
            imageView.contentMode = .ScaleAspectFill
            imageView.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "imageViewClick:")
            imageView.addGestureRecognizer(tap)
            imageScrollView.addSubview(imageView)
            allImgs.append(imageView)
        }
        
        pageControl = UIPageControl.newAutoLayoutView()
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = Constant.Common.OrangeColor
        addSubview(pageControl)
        
    }
    
    func imageViewClick(tap: UITapGestureRecognizer) {
        if bannerImageClick != nil {
            let img = tap.view! as! BannerImageView
            bannerImageClick!(index: img.bannerId)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageScrollView.frame = bounds
        
        var height: CGFloat = 380.0.fitHeight()
        if imgs.count > 0 {
            height = 600.0.fitHeight()
        }
        for index in 0..<imageViewMaxCount {
            let img = allImgs[index]
            img.frame = CGRectMake(ScreenSize.SCREEN_WIDTH * CGFloat(index), 0, ScreenSize.SCREEN_WIDTH, height)
        }
        pageControl.autoAlignAxisToSuperviewAxis(.Vertical)
        pageControl.autoPinEdgeToSuperviewMargin(.Bottom)
        pageControl.autoSetDimension(.Height, toSize: 50.0.fitHeight())
        imageScrollView.setContentOffset(CGPointMake(ScreenSize.SCREEN_WIDTH, 0), animated: false)
    }
    
    
    //MARK: 更新内容
    private func updatePageScrollView() {
        for var i = 0; i < allImgs.count; i++ {
            let imageView = allImgs[i]
            var index = pageControl.currentPage
            
            if i == 0 {
                index--
            } else if i == 2 {
                index++
            }
            
            if index < 0 {
                index = self.pageControl.numberOfPages - 1
            } else if index >= pageControl.numberOfPages {
                index = 0
            }
            imageView.tag = index
            // MARK: 更新img
            if chefBanner.count != 0 {
                imageView.bannerId = chefBanner[index].bannerId
                imageView.sd_setImageWithURL(NSURL(string: chefBanner[index].imageurl!), placeholderImage: nil)
            }else if choiceBanner.count != 0{
                imageView.bannerId = choiceBanner[index].bannerId
                imageView.title = choiceBanner[index].title
                imageView.sd_setImageWithURL(NSURL(string: choiceBanner[index].banner_image!), placeholderImage: nil)
            }else if imgs.count != 0{
                imageView.sd_setImageWithURL(NSURL(string: imgs[index]), placeholderImage: nil)
            }
        }
        imageScrollView.contentOffset = CGPointMake(imageScrollView.width, 0)
    }
    
    // MARK: Timer
    private func startTimer() {
        timer = NSTimer(timeInterval: 5.0, target: self, selector: "next", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func next() {
        imageScrollView.setContentOffset(CGPointMake(2.0 * imageScrollView.frame.size.width, 0), animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i in 0..<allImgs.count {
            let imageView = allImgs[i]
            if imageView.isKindOfClass(UIImageView) {
                let distance:CGFloat = abs(imageView.x - scrollView.contentOffset.x)
                if distance < minDistance {
                    minDistance = distance
                    page = imageView.tag
//                    print(page)
                }
                
            }
        }
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageScrollView()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updatePageScrollView()
    }
}

class BannerImageView: UIImageView {
    
    var bannerId: Int = 0
    var title: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
