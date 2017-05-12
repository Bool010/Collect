//
//  WNScanBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Life Cycle
class WNScanBoard: UIViewController {

    private var statusBarStyle: UIStatusBarStyle = .default
    fileprivate var session = AVCaptureSession.init()
    fileprivate var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    fileprivate var qrCodeView: UIView?
    fileprivate var input:AVCaptureDeviceInput?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        self.startScan()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        statusBarStyle = self.preferredStatusBarStyle
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = statusBarStyle
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    deinit {
        wn_deinitMessage("扫码")
    }
}

// MARK: - UI
extension WNScanBoard {
    
    fileprivate func buildUI() -> Void {
        
        let navView = self.view.addNavigation { [weak self] (leftBtn, rightBtn, titleLabel, lineView) in
            
            titleLabel.textColor = .white
            titleLabel.text = "扫一扫"
            
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let __self = self else { return }
                _ = __self.navigationController?.popViewController(animated: true)
            })
        }
        navView.backgroundColor = UIColor.black
        
        //
    }
    
}

// MARK: - Function
extension WNScanBoard {
    
    fileprivate func startScan() -> Void {
        
        // Input
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            input = try AVCaptureDeviceInput.init(device: captureDevice)
        } catch let error {
            print("调用相机接口出现错误\(error.localizedDescription)")
        }
        session = AVCaptureSession.init()
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        // Output
        let output = AVCaptureMetadataOutput.init()
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        // Video Preview Layer
        videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: session)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        session.startRunning()
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            
//        } else {
//            showMessage(title: "提示", message: "没有相机权限，请到设置->隐私中开启该应用相机权限")
//        }
    }
    
    
    fileprivate func showMessage(title: String, message: String) -> Void {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "知道了", style: .cancel, handler: { (action) in
                
            })
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertView.init(title: title, message: message, delegate: nil, cancelButtonTitle: "知道了")
            alert.show()
        }
    }
}

// MARK: - Delegate
extension WNScanBoard: UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    
}
