//
//  DetectorController.swift
//  QRCode
//
//  Created by 王继伟 on 16/7/15.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class DetectorController: UIViewController {
    // MARK:- 控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showResults_Lable: UILabel!
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 1.获取当前显示的图片
        let currentImage = imageView.image!
        
        // 2.识别二维码
        let resultArray = QRCodeManager.shareInstance.detectorQRCode(currentImage)
        for result in resultArray {
            print(result)
        }
    }
}

extension DetectorController {
    @IBAction func albumOpen() {
        // 1.判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            return
        }
        
        // 2.创建图片选择控制器
        let ipc = UIImagePickerController()
        
        // 3.设置照片来源
        ipc.sourceType = .PhotoLibrary
        
        // 4.设置代理(在代理方法拿用户选中的照片)
        ipc.delegate = self
        
        // 5.弹出控制器
        presentViewController(ipc, animated: true, completion: nil)
    }
}


extension DetectorController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 获取选中的图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // 将图片设置到imageView中
        imageView.image = image
        
        // 退出控制器
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}








































