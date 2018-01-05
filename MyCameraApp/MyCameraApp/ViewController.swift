//
//  ViewController.swift
//  MyCameraApp
//
//  Created by user on 10/28/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit
import MobileCoreServices //use camera

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var btnShare: UIButton!
    
    var myImageController : UIImagePickerController?
    var isNewImage = false
    
    @IBAction func postMethod() {
        let activityItems : [AnyObject]? = [myImageView.image!]
        
        let activityController = UIActivityViewController(activityItems: activityItems!,applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivityType.mail, UIActivityType.copyToPasteboard]
        activityController.completionWithItemsHandler = {(activityType, completed, returnedItems, error) in
            var resultMessage = ""
            if completed {
                if error == nil {
                    self.myImageView.image = nil
                    resultMessage = "Successful!"
                } else{
                    resultMessage = "Error : \(error!)"
                }
                let alertController = UIAlertController(title: "Result", message: resultMessage, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK",style: .default, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true,completion: nil)
            }
        }
        self.present(activityController, animated: true, completion: nil)
    
    }
    
    @IBAction func cameraMethod() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            myImageController = UIImagePickerController()
            if let theController = myImageController{
                theController.sourceType = .camera
                theController.mediaTypes = [String(kUTTypeImage)]
                theController.allowsEditing = true
                theController.delegate = self
                present(theController, animated: true, completion: nil)
                isNewImage = true
            }
        } else {
            let alertController = UIAlertController(title: "MyCameraApp", message: "ไม่สามารถเปิดกล้องได้", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "ปิดหน้าต่าง", style: .cancel, handler: nil)
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraRollMethod() {
        myImageController = UIImagePickerController()
        if let theController = myImageController {
            theController.sourceType = .savedPhotosAlbum
            theController.mediaTypes = [String(kUTTypeImage)]
            theController.allowsEditing = true
            theController.delegate = self
            present(theController, animated: true, completion: nil)
            isNewImage = false
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let theImage = info[UIImagePickerControllerEditedImage] as!UIImage
        myImageView.image = theImage
        
        btnShare.isHidden = false
        
        if isNewImage {
            UIImageWriteToSavedPhotosAlbum(theImage, self, nil, nil)
            isNewImage = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyCameraApp"
        btnShare.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

