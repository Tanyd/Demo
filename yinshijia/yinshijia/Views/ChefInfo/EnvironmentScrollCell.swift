//
//  EnvironmentScrollCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class EnvironmentScrollCell: UITableViewCell, UIScrollViewDelegate {

    private var imageScrollView: UIScrollView!

    private var allImgs = [UIImageView]()
    
    private var currentIndex: Int = 0
    
    var imgs = [String]() {
        didSet{
            if imgs.count > 0 {
                currentIndex = 0
                updatePageScrollView()
            }
        }
        
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        imageScrollView = UIScrollView.newAutoLayoutView()
        imageScrollView.bounces = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.pagingEnabled = true
        imageScrollView.delegate = self
        imageScrollView.contentSize = CGSizeMake(CGFloat(3) * ScreenSize.SCREEN_WIDTH, 0)
        addSubview(imageScrollView)
        
        for _ in 0..<3 {
            let imageView = UIImageView(frame: CGRectZero)
            imageView.contentMode = .ScaleAspectFill
            imageScrollView.addSubview(imageView)
            allImgs.append(imageView)
        }        
    }
    
    private func updatePageScrollView() {
        for var i = 0; i < allImgs.count; i++ {
            let imageView = allImgs[i]
            var index = currentIndex
            if i == 0 {
                index--
            } else if i == 2 {
                index++
            }
            
            if index < 0 {
                index = imgs.count - 1
            } else if index >= imgs.count {
                index = 0
            }
            imageView.tag = index
            // MARK: 更新img
            imageView.sd_setImageWithURL(NSURL(string: imgs[index]), placeholderImage: nil)
        }
        imageScrollView.contentOffset = CGPointMake(imageScrollView.width, 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageScrollView.frame = CGRectMake(30.0.fitWidth(), 30.0.fitHeight(), ScreenSize.SCREEN_WIDTH - 60.0.fitWidth(), bounds.height - 60.0.fitHeight())
        
        let height: CGFloat = imageScrollView.frame.size.height
        let width: CGFloat = imageScrollView.frame.size.width
        for index in 0..<3 {
            let img = allImgs[index]
            img.frame = CGRectMake(width * CGFloat(index), 0, width, height)
        }
        imageScrollView.setContentOffset(CGPointMake(width, 0), animated: false)
    }
    
    
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
                }
                
            }
        }
        currentIndex = page
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
