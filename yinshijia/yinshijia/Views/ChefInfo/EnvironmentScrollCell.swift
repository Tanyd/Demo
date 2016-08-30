//
//  EnvironmentScrollCell.swift
//  yinshijia
//
//  Created by tanyadong on 16/7/6.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit

class EnvironmentScrollCell: UITableViewCell, UIScrollViewDelegate {

    private var didUpdateConstraints = false
    private var imageScrollView: UIScrollView!
    private var allImgs = [UIImageView]()
    private var numberCount: UILabel!
    private var currentIndex: Int = 0{
        didSet{
            numberCount?.text = "\(currentIndex + 1)/\(imgs.count)"
        }
    }
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
        imageScrollView = UIScrollView()
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
        
        numberCount = UILabel.labelCustomer(nil, fontType: nil, color: UIColor.whiteColor(), fontSize: 12)
        numberCount.textAlignment = .Right
        addSubview(numberCount)
        setNeedsUpdateConstraints()
    }
    
    private func updatePageScrollView() {
      
        for i in 0 ..< allImgs.count {
            let imageView = allImgs[i]
            var index = currentIndex
            if i == 0 {
                index -= 1
            } else if i == 2 {
                index += 1
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
    
    func configureModel(model: [ChefInfoKitchenimage]?) {
        var temp = [String]()
        for obj in model! {
            temp.append(obj.environmenturl!)
        }
        imgs = temp
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageScrollView.frame = CGRectMake(30.0.fitWidth(), 30.0.fitHeight(), ScreenSize.SCREEN_WIDTH - 60.0.fitWidth(), bounds.height - 60.0.fitHeight())
        numberCount.frame = CGRectMake(CGRectGetMaxX(imageScrollView.frame) - 100.0.fitWidth(), CGRectGetMaxY(imageScrollView.frame) - 50.0.fitHeight(), 100.0.fitWidth(), 50.0.fitHeight())
        
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
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageScrollView()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updatePageScrollView()
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
