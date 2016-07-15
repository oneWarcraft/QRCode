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
        
        // 3.生成高清的图片
        let hdImage = createHDImage(outputImage)
        

        print(hdImage)
        
        // 3.将生成的二维码显示在imageView中
        imageView.image = hdImage
    }
    
    private func createHDImage(ciImage: CIImage) -> UIImage {
        // 1. 放大图片
        let transform = CGAffineTransformMakeScale(10, 10)
        let newCIImage = ciImage.imageByApplyingTransform(transform)

        // 2. 创建UIImage对象
        return UIImage(CIImage: newCIImage)
    }
}

