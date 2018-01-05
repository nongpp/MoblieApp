//
//  ScanQRViewController.swift
//  MyQRCodeApp
//
//  Created by DrKeng on 9/26/2560 BE.
//  Copyright © 2560 ANT. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblResult: UILabel!
    
    var captureSession : AVCaptureSession?
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var qrCodeFrameView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        var inputDevice : AVCaptureDeviceInput?
        do {
            inputDevice = try AVCaptureDeviceInput(device: captureDevice!)
        } catch let error as NSError {
            print(error.description)
            return
        }
        
        captureSession = AVCaptureSession()
        
        captureSession?.addInput(inputDevice!)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        view.bringSubview(toFront: headerView)
        view.bringSubview(toFront: lblResult)
        
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView?.layer.borderWidth = 2
        
        view.addSubview(qrCodeFrameView!)
        view.bringSubview(toFront: qrCodeFrameView!)
        
        captureSession?.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            lblResult.text = "ยังไม่สามารถตรวจจับ QR Code ได้"
        } else {
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            if metadataObj.type == AVMetadataObject.ObjectType.qr {
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeFrameView?.frame = (barCodeObject?.bounds)!
                
                if metadataObj.stringValue != nil {
                    lblResult.text = metadataObj.stringValue
                    captureSession?.stopRunning()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backMethod() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
