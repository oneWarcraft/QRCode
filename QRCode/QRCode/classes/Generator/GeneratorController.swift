//
//  GeneratorController.swift
//  QRCode
//
//  Created by 王继伟 on 16/7/15.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit
import CoreImage

class GeneratorController: UIViewController {
    private let ImageViewW : CGFloat = 240
    
    // MARK:- 控件属性
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var GenerateQRcode_UIButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

}

// MARK:- 生成二维码
extension GeneratorController {
    
    @IBAction func generateQRCodeClickBTN() {
        
        // 0.退出键盘
        view.endEditing(true)
        
        // 1.获取用户输入的内容
        guard let inputMsg = textField.text else {
            print("没有输入内容")
            return
        }
        
        guard inputMsg.characters.count != 0 else {
            print("没有输入具体内容")
            return
        }
        
        // 2.将内容生成二维码
        // 2.1.创建过滤器(滤镜) : CIQRCodeGenerator --> 创建二维码的过滤器
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        
        // 2.2.给滤镜设置内容(KVC)
        let inputData = inputMsg.dataUsingEncoding(NSUTF8StringEncoding)
        filter.setValue(inputData, forKey: "inputMessage")
        
        // 设置二维码的容错率
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        // 2.3.获取生成的二维码图片
        guard let outputImage = filter.outputImage else {
            return
        }
        print(outputImage)
        // 3.生成高清的图片
        let hdImage = createHDImage(outputImage, ratio: ImageViewW / outputImage.extent.width)

        print(hdImage)
        
        // 4. 获取前景图片
        let fgImage = UIImage(named: "erha")
        
        // 5. 获取有前景图片的二维码
        let newImage = createImageWithFGImage(hdImage, fgImage: fgImage!)
        
        // 3.将生成的二维码显示在imageView中
        imageView.image = newImage
    }
    
    private func createHDImage(ciImage: CIImage, ratio : CGFloat) -> UIImage {
        
        // 1. 放大图片
        let transform = CGAffineTransformMakeScale(ratio, ratio)
        let newCIImage = ciImage.imageByApplyingTransform(transform)

        // 2. 创建UIImage对象
        return UIImage(CIImage: newCIImage)
    }
    
    private func createImageWithFGImage(hdImage : UIImage, fgImage : UIImage) -> UIImage {
        // 0.获取高清图片的尺寸
        let size = hdImage.size
        
        // 1.开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 2.将高清图片画到上下文
        hdImage.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        // 3.将小图画上去
        let w : CGFloat = 60
        let h : CGFloat = 60
        let x : CGFloat = (size.width - w) * 0.5
        let y : CGFloat = (size.height - h) * 0.5
        fgImage.drawInRect(CGRect(x: x, y: y, width: w, height: h))
        
        // 4.从上下文中获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5.关闭上下文
        UIGraphicsEndImageContext()
    
        return newImage
    }
}

