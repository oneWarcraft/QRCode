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
        QRCodeManager.shareInstance.startScannning(self, inView: view)
    }
}


extension ScanningController : AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for objc in metadataObjects {
            let qrCodeObject = objc as! AVMetadataMachineReadableCodeObject
            print(qrCodeObject.stringValue)
            
            QRCodeManager.shareInstance.stopScanning()
        }
    }
}

