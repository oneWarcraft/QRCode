//
//  ScanningController.swift
//  QRCode
//
//  Created by 王继伟 on 16/7/15.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class ScanningController: UIViewController {
//class ScanningController: UIViewController {
    
    @IBOutlet weak var scanLineBottomCons: NSLayoutConstraint!
    @IBOutlet weak var scanBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startScanAnimation()
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
}