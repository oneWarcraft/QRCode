//
//  ScanningController.swift
//  QRCode
//
//  Created by 王继伟 on 16/7/15.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit
import AVFoundation

class ScanningController: UIViewController {
//class ScanningController: UIViewController {
    
    @IBOutlet weak var scanLineBottomCons: NSLayoutConstraint!
    @IBOutlet weak var scanBgView: UIView!
    
    var session : AVCaptureSession?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.开始扫描动画
        startScanAnimation()
        
        // 2.开始扫描
        startScanning()
    }
    
}

extension ScanningController {
    private func startScanAnimation() {
        // 1.修改约束
        scanLineBottomCons.constant = -240
        
        // 2.执行动画
        UIView.animateWithDuration(1.5) { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            self.scanBgView.layoutIfNeeded()
        }
    }
    
    private func startScanning() {
        // 1.创建输入(摄像头)
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("获取摄像头过程中有异常")
            return
        }
        
        // 2.创建输出(Metadata)
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        // 3. 创建会话，联系输入和输出
        let session = AVCaptureSession()
        session.addInput(input)
        session.addOutput(output)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        self.session = session

    }
}

extension ScanningController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        print("扫描结果")
    }
}


