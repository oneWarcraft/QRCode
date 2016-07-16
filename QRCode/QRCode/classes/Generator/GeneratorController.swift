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
        
        // 2.将内容生成二维码
        self.imageView.image = QRCodeManager.shareInstance.generateQRCode(inputMsg, fgImage: UIImage(named: "erha"), qrCodeSize: 240)
    }
}

