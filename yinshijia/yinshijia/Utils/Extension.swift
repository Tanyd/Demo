//
//  Extension.swift
//  yinshijia
//
//  Created by Developer on 16/6/10.
//  Copyright © 2016年 tanyadong. All rights reserved.
//

import UIKit


import Foundation
import UIKit

extension UIView {
    
    /// X值
    var x: CGFloat {
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return self.frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
    
    
    func takeSnapshot() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0.0)
        self.drawViewHierarchyInRect(self.frame, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func takeSnapshotWithoutTabbar(tabbarHeight: CGFloat) -> UIImage{
        let snapShotSize = CGSizeMake(self.frame.size.width * 2, (self.frame.size.height - tabbarHeight) * 2)
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0.0)
        self.drawViewHierarchyInRect(self.frame, afterScreenUpdates: true)
        let tempImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let subImageRef: CGImageRef = CGImageCreateWithImageInRect(tempImage.CGImage, CGRect(origin: self.frame.origin, size: snapShotSize))!
        let subBounds: CGRect = CGRect(origin: CGPointZero, size: snapShotSize)
        UIGraphicsBeginImageContext(subBounds.size)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextDrawImage(context, subBounds, subImageRef)
        let image: UIImage = UIImage(CGImage: subImageRef)
        UIGraphicsEndImageContext()
        return image
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(self, options: nil)[0] as? UIView
    }
    
    //    func takeSnapshot() -> UIImage {
    //        UIGraphicsBeginImageContext(self.frame.size)
    //        self.drawViewHierarchyInRect(CGRect(origin: CGPointZero, size: self.frame.size), afterScreenUpdates: false)
    //        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        return image.applyBlurWithRadius(5, tintColor: UIColor(white: 1, alpha: 0.6), saturationDeltaFactor: 1.5, maskImage: nil)!
    //    }
}
extension Double{
    func fitWidth() -> CGFloat{
        return CGFloat((self / 750.0)) * ScreenSize.SCREEN_WIDTH
    }
    
    func fitHeight() -> CGFloat{
        return CGFloat((self / 1334.0)) * ScreenSize.SCREEN_HEIGHT
    }
    
    func fit6PlusWith() -> CGFloat{
        return CGFloat((self / 1242.0)) * ScreenSize.SCREEN_WIDTH
    }
    
    func fit6PlusHeight() -> CGFloat{
        return CGFloat((self / 2208.0)) * ScreenSize.SCREEN_HEIGHT
    }
    
}



extension UIFont {
    class func HiraKakuProNW6(size: CGFloat) -> UIFont{
        return UIFont(name: "HiraKakuProN-W6", size: size)!
    }
    
    class func HiraKakuProNW3(size: CGFloat) -> UIFont{
        return UIFont(name: "HiraKakuProN-W3", size: size)!
    }
    
    class func Helvetica(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func HelveticaBold(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func HelveticaMedium(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func HelventicaNeue(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
}

extension NSObject{
    static var className: String{
        get{
            return self.description().componentsSeparatedByString(".").last!
        }
    }
}

extension UITableView{
    func dequeueCell<T: UITableViewCell>(cell: T.Type) -> T? {
        return dequeueReusableCellWithIdentifier(T.className) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(cell: T.Type, id: String) -> T? {
        return dequeueReusableCellWithIdentifier(id) as? T
    }
    
}
extension UIButton {
    class func buttonCustomer(frame: CGRect? ,titleNormal: String?, titleSelected: String?,backColor: UIColor?, backImg: String?, imgNormal: String?, imgSelected: String?, target: AnyObject?, action: Selector) -> UIButton{
        let btn = UIButton(type: .Custom)
        if frame != nil {
            btn.frame = frame!
        }
        if titleNormal != nil {
            btn.setTitle(titleNormal, forState: .Normal)
        }
        if titleSelected != nil {
            btn.setTitle(titleSelected, forState: .Normal)
        }
        if backColor != nil {
            btn.backgroundColor = backColor
        }
        if backImg != nil {
            btn.setBackgroundImage(UIImage(named: backImg!), forState: .Normal)
        }
        if imgNormal != nil {
            btn.setImage(UIImage(named: imgNormal!), forState: .Normal)
        }
        if imgSelected != nil {
            btn.setImage(UIImage(named: imgSelected!), forState: .Selected)
        }
        if target != nil && action != nil  {
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
    
    class func buttonCustomerTarget(frame: CGRect?, target: AnyObject?, action: Selector) -> UIButton{
        
        return buttonCustomer(frame, titleNormal: nil, titleSelected: nil, backColor: nil, backImg: nil, imgNormal: nil, imgSelected: nil, target: target, action: action)
    }
    
    
    
    
    func verticalImageAndTitle(space: CGFloat){
        let imageSize = imageView!.frame.size
        let titleSize = titleLabel!.frame.size
        let totalHeight = (imageSize.height + titleSize.height + space)
        imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width)
        titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0)
    }
    
}

extension UILabel{
    
    class func lableCutomer(title :String?,fontType: String? ,color :UIColor,fontSize : CGFloat)-> UILabel {
        let lable = UILabel()
        lable.text = title
        if fontType == nil {
            lable.font = UIFont.systemFontOfSize(fontSize)
        }else {
            lable.font = UIFont(name: fontType!, size: fontSize)
        }
        lable.textColor = color
        return lable
    }
    
    func alignTop(){
        let fontSize = (self.text! as NSString).sizeWithAttributes([NSFontAttributeName: self.font])
        let finalHeight: CGFloat = fontSize.height * CGFloat(self.numberOfLines)
        let finalWidth: CGFloat = self.frame.size.width
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        let stringSize = (self.text! as NSString).boundingRectWithSize(CGSizeMake(finalWidth, finalHeight), options: NSStringDrawingOptions.UsesFontLeading, attributes: [NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        let newLines: Int = Int((finalHeight - stringSize.height) / fontSize.height)
        for _ in 0...newLines{
            self.text = self.text?.stringByAppendingString(" \n")
        }
    }
    
    func lineNumbers(text: String, font: UIFont, maxWidth: CGFloat) -> Int{
        let fontSize = (text as NSString).sizeWithAttributes([NSFontAttributeName: font])
        return fontSize.width > maxWidth ? 2 : 1
    }
    
    func defaultAttributedText(txt: String, lineSpacing: CGFloat, maxWidth: CGFloat){
        let attrText = NSMutableAttributedString(string: txt)
        let bodyRange = NSMakeRange(0, txt.length())
        attrText.addAttribute(NSFontAttributeName, value: self.font, range: bodyRange)
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        if self.lineNumbers(txt, font: self.font, maxWidth: maxWidth) > 1{
            paragraphStyle.lineSpacing = lineSpacing
        }else{
            paragraphStyle.lineSpacing = 0
        }
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        let lineHeight = self.font.lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: bodyRange)
        self.attributedText = attrText
    }
    
    func getLineNumbers(text: String, availableWidth: CGFloat, lineSpacing: CGFloat) -> Int{
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        let lineHeight = self.font.lineHeight
        paragraphStyle.minimumLineHeight = ceil(lineHeight)
        let textSize = (text as NSString).sizeWithAttributes([NSFontAttributeName: self.font, NSParagraphStyleAttributeName: paragraphStyle])
        var lines = 0
        if textSize.width % availableWidth == 0{
            lines = Int(textSize.width / availableWidth)
        }else{
            lines = Int(textSize.width / availableWidth) + 1
        }
        return lines
    }
    
    func addAttributedText(txt: String, lineSpacing: CGFloat) -> NSMutableAttributedString{
        let attrText = NSMutableAttributedString(string: txt)
        let bodyRange = NSMakeRange(0, txt.length())
        attrText.addAttribute(NSFontAttributeName, value: self.font, range: bodyRange)
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        let lineHeight = self.font.lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: bodyRange)
        //        self.attributedText = attrText
        return attrText
    }
}

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageWithColor(color: UIColor,size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(origin: CGPointZero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // 截屏
    class func cutScreenWithView(view: UIView) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // 压缩
    func imageByScalingAndCroppingForSize(targetSize : CGSize) -> UIImage {
        
        let sourceImage = self
        var newImage : UIImage?
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = targetSize.width
        let targetHeight = targetSize.height
        var scaleFactor : CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPointMake(0.0,0.0)
        if (CGSizeEqualToSize(imageSize, targetSize) == false)
        {
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            if (widthFactor > heightFactor){
                scaleFactor = widthFactor // scale to fit height
            }else {
                scaleFactor = heightFactor // scale to fit width
                scaledWidth = width * scaleFactor
                scaledHeight = height * scaleFactor
            }
            
            // center the image
            if (widthFactor > heightFactor)
            {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }
            else if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContext(targetSize); // this will crop
        
        var thumbnailRect = CGRectZero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        sourceImage.drawInRect(thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        if(newImage == nil){
            NSLog("could not scale image");
        }
        //pop the context to get back to the default
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 圆圆环图
    class func circleWithImage(image: UIImage, borderWidth: CGFloat,borderColor: UIColor) -> UIImage{
        let oldImg = image
        let imageW = oldImg.size.width + 2 * borderWidth
        let imageH = oldImg.size.height + 2 * borderWidth
        let imageSize = CGSizeMake(imageW, imageH)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext()
        borderColor.set()
        let bigRadius = imageW * 0.5
        let centerX = bigRadius
        let centerY = bigRadius
        CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, CGFloat(M_PI) * 2, 0)
        CGContextFillPath(ctx)
        
        let smallRadius = bigRadius - borderWidth
        CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, CGFloat(M_PI) * 2, 0)
        CGContextClip(ctx)
        
        oldImg.drawInRect(CGRect(x: borderWidth, y: borderWidth, width: oldImg.size.width, height: oldImg.size.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg

    }
    
    
    class func circleImage(imageName: String, borderWidth: CGFloat,borderColor: UIColor) -> UIImage{
        let oldImg = UIImage(named: imageName)
        let imageW = oldImg!.size.width + 2 * borderWidth
        let imageH = oldImg!.size.height + 2 * borderWidth
        let imageSize = CGSizeMake(imageW, imageH)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext()
        borderColor.set()
        let bigRadius = imageW * 0.5
        let centerX = bigRadius
        let centerY = bigRadius
        CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, CGFloat(M_PI) * 2, 0)
        CGContextFillPath(ctx)
        
        let smallRadius = bigRadius - borderWidth
        CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, CGFloat(M_PI) * 2, 0)
        CGContextClip(ctx)
        
        oldImg?.drawInRect(CGRect(x: borderWidth, y: borderWidth, width: oldImg!.size.width, height: oldImg!.size.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
    // 缩放图片
    func resizeImage(image: UIImage, toWidth width: CGFloat, withHeight height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        // 开启一个上下文
        /// 设置为false 表示背景不透明 -> 黑色
        /// 设置为 0 -> 可以自适应不同的屏幕的scale显示
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        /// 绘制图片
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        // 取得图片
        let retrivedImage = UIGraphicsGetImageFromCurrentImageContext()
        // 结束上下文
        UIGraphicsEndImageContext()
        return retrivedImage
    }
    //    // 缩放图片
    //    func resizeImage(image: UIImage, toWidth width: CGFloat, withHeight height: CGFloat) -> UIImage {
    //        let size = CGSize(width: width, height: height)
    //        // 开启一个上下文
    //        /// 设置为false 表示背景不透明 -> 黑色
    //        /// 设置为 0 -> 可以自适应不同的屏幕的scale显示
    //        UIGraphicsBeginImageContextWithOptions(size, false, 0)
    //        // 获取上下文
    //        let context = UIGraphicsGetCurrentContext()
    //        // 转换坐标原点到左下角
    //        CGContextTranslateCTM(context, 0.0, height)
    //        CGContextScaleCTM(context, 1.0, -1.0)
    //        // 设置绘制模式
    //        CGContextSetBlendMode(context, .Copy)
    //        // 绘图
    //        CGContextDrawImage(context, CGRect(origin: CGPointZero, size: size), image.CGImage)
    //        // 取得图片
    //        let retrivedImage = UIGraphicsGetImageFromCurrentImageContext()
    //        // 结束上下文
    //        UIGraphicsEndImageContext()
    //        return retrivedImage
    //    }
    
    // 拉伸
    
    class func resizableImage(imgName: String) -> UIImage {
        let img = UIImage(named: imgName)
        return img!.stretchableImageWithLeftCapWidth(Int(img!.size.width * CGFloat(0.5)), topCapHeight: Int(img!.size.height * CGFloat(0.5)))
    }
    
    // 裁剪
    class func cutImage(image: UIImage, cutRect: CGRect) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(cutRect.size, false, 0.0)
        // 获取上下文
        let context = UIGraphicsGetCurrentContext()
        image.drawInRect(cutRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //   class func cutImage(image: UIImage, cutRect: CGRect) -> UIImage {
    //
    //        UIGraphicsBeginImageContextWithOptions(cutRect.size, false, 0.0)
    //        // 获取上下文
    //        let context = UIGraphicsGetCurrentContext()
    //        // 转换坐标原点到左下角
    //        CGContextTranslateCTM(context, 0.0, cutRect.size.height)
    //        CGContextScaleCTM(context, 1.0, -1.0)
    //        // 设置绘制模式
    //        CGContextSetBlendMode(context, .Copy)
    //        // 绘图
    //        CGContextDrawImage(context, cutRect, image.CGImage)
    //        let image = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        return image
    //    }
}





extension UIWebView{
    func clean(){
        self.loadHTMLString("", baseURL: nil)
        self.stopLoading()
        self.delegate = nil
        self.removeFromSuperview()
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        NSURLCache.sharedURLCache().diskCapacity = 0
        NSURLCache.sharedURLCache().memoryCapacity = 0
    }
    
}

extension UIColor {
    
    class func colorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    class func RGB(Red:CGFloat, Green:CGFloat,Blue:CGFloat,Alpha:CGFloat) ->UIColor{
        return UIColor(red: Red/255, green: Green/255, blue: Blue/255, alpha: Alpha)
    }
    class func mainColor() -> UIColor{
        return UIColor.RGB(156, Green: 193, Blue: 85, Alpha: 1)
    }
}

extension NSData {
    convenience init(jsonDictionary: [String: AnyObject]) throws {
        self.init(data:
            try NSJSONSerialization.dataWithJSONObject (jsonDictionary, options: NSJSONWritingOptions(rawValue: 0))
        )
    }
}
extension NSString {
    
    func getTextRectSize(font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = self.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
    
}
extension String{
    
    var MD5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return hash as String
    }
    
    func md5() ->String!{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        var hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        return String(format: hash as String)
    }
    
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!  as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!  as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     将当前字符串拼接到LibraryDirectory目录后面
     */
    func libDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!  as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    
    // 手机号码 判断
    
    func isPhoneNumber() -> Bool {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(self) == true)
            || (regextestcm.evaluateWithObject(self)  == true)
            || (regextestct.evaluateWithObject(self) == true)
            || (regextestcu.evaluateWithObject(self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    
    func length() -> Int{
        return (self as NSString).length
    }
    
    func toDate(dateFm: String) -> NSDate{
        let df = NSDateFormatter()
        df.dateFormat = dateFm
        return df.dateFromString(self)!
    }
    
    static func SimpleDate(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(date)
    }
    
    static func SimpleDateTime(serverDate: String) -> String{
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = dateFormatter.dateFromString(serverDate)
        
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        return dateFormatter.stringFromDate(date!)
    }
    
    static func StringFromDate(date: NSDate) -> String{
        let fmt = NSDateFormatter()
        fmt.dateStyle = NSDateFormatterStyle.MediumStyle
        return fmt.stringFromDate(date)
    }
    
    static func StringFromFullDate(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.stringFromDate(date)
    }
    
    static func StringFromTime(date: NSDate) -> String{
        let fmt = NSDateFormatter()
        fmt.dateFormat = "HH:mm"
        return fmt.stringFromDate(date)
    }

}

extension NSObject {
    
    func propertyNames() -> Array<String> {
        var results: Array<String> = [];
        
        var count: UInt32 = 0;
        let myClass: AnyClass = self.classForCoder;
        let properties = class_copyPropertyList(myClass, &count);
        
        for var i: UInt32 = 0; i < count; i++ {
            let property = properties[Int(i)];
            let cname = property_getName(property);
            let name = String.fromCString(cname);
            results.append(name!);
        }
        
        free(properties);
        
        return results;
    }
}

extension UIViewController {
    
    func setupClass(fromStr: String) -> UIViewController {
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let cls:AnyClass? = NSClassFromString(ns + "." + fromStr)
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        return vc
    }
    
    func setNavigationBarLeftItem(imageName imageName: String!, highlightImageName: String? = nil) -> UIButton? {
        let leftImage: UIImage = UIImage(named: imageName)!
        let leftButton: UIButton = UIButton(type: UIButtonType.Custom)
        leftButton.setImage(leftImage, forState: UIControlState.Normal)
        if let name = highlightImageName {
            leftButton.setBackgroundImage(UIImage(named: name), forState: UIControlState.Highlighted)
        }
        leftButton.contentHorizontalAlignment = .Left
        leftButton.frame = CGRect(origin: CGPointZero, size: CGSize(width: 40, height: leftImage.size.height))
        leftButton.addTarget(self, action: "leftItemHandle", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        return leftButton
    }
    
    func setNavigationBarRightItem(imageName imageName: String!, highlightImageName: String? = nil) -> UIButton? {
        let rightImage: UIImage = UIImage(named: imageName)!
        let rightButton: UIButton = UIButton(type: UIButtonType.Custom)
        rightButton.setImage(rightImage, forState: UIControlState.Normal)
        if let name = highlightImageName {
            rightButton.setImage(UIImage(named: name), forState: UIControlState.Highlighted)
        }
        rightButton.contentHorizontalAlignment = .Right
        rightButton.frame = CGRect(origin: CGPointZero, size: CGSize(width: 40, height: rightImage.size.height))
        rightButton.addTarget(self, action: "rightItemHandle:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        return rightButton
    }
    

    func setNavigationBarRightItem(imageName imageName: String!, selectedImageName: String? = nil) -> UIButton? {
        let rightImage: UIImage = UIImage(named: imageName)!
        let rightButton: UIButton = UIButton(type: UIButtonType.Custom)
        rightButton.setBackgroundImage(rightImage, forState: UIControlState.Normal)
        if let name = selectedImageName {
            rightButton.setBackgroundImage(UIImage(named: name), forState: UIControlState.Selected)
        }
        rightButton.frame = CGRect(origin: CGPointZero, size: rightImage.size)
        rightButton.addTarget(self, action: "rightItemHandle", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        return rightButton
    }
    
    func setTopPageNavigationBarRightItem(image: String) -> UIButton?{
        let rightImage: UIImage = UIImage(named: image)!
        let rightButton: UIButton = UIButton(type: UIButtonType.Custom)
        rightButton.setBackgroundImage(rightImage, forState: UIControlState.Normal)
        rightButton.frame = CGRect(origin: CGPointMake(200, 0), size: rightImage.size)
        rightButton.addTarget(self, action: "rightItemHandle", forControlEvents: UIControlEvents.TouchUpInside)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spacer.width = -5
        navigationItem.rightBarButtonItems = [spacer, UIBarButtonItem(customView: rightButton)]
        
        
        return rightButton
    }
    
    
    
    func setNavigationBarRightButton(title: String!, selectedTitle: String? = nil) -> UIButton{
        let rightButton: UIButton = UIButton(type: UIButtonType.Custom)
        rightButton.frame = CGRect(origin: CGPointZero, size: CGSizeMake(80.0, 60.0))
        rightButton.setTitle(title, forState: UIControlState.Normal)
        rightButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        if let name = selectedTitle {
            rightButton.setTitle(name, forState: UIControlState.Selected)
        }
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spacer.width = -30
        
        navigationItem.rightBarButtonItems = [spacer, UIBarButtonItem(customView: rightButton)]
        return rightButton
        
    }
    

}
