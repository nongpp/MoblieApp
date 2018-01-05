//
//  AddStudentViewController.swift
//  RateMyStudentDB
//
//  Created by user on 10/28/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class AddStudentViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var myImageController : UIImagePickerController?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtStudent: UITextField!
    @IBOutlet weak var txtScore: UITextField!
    
    @IBAction func selectImgMethod(_ sender: Any) {
        myImageController = UIImagePickerController()
        if let theController = myImageController {
            theController.sourceType = .savedPhotosAlbum
            theController.mediaTypes = [String(kUTTypeImage)]
            theController.allowsEditing = true
            theController.delegate = self
            present(theController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let theImage = info[UIImagePickerControllerEditedImage] as!UIImage
        imgView.image = theImage
    }
    
    @IBAction func saveMethod(_ sender: Any) {
        let myAppDelegate = UIApplication.shared.delegate as!AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let newStudent = NSEntityDescription.insertNewObject(forEntityName: "StudentTB", into: myContext)
        
        newStudent.setValue(txtStudent.text!, forKey: "studentName")
        newStudent.setValue(Int(txtScore.text!)!, forKey: "studentRatingScore")
        
        let theImageData = UIImagePNGRepresentation(imgView.image!)!as NSData
        
        newStudent.setValue(theImageData, forKey: "studentImage")
        
        do {
            try myContext.save()
            print("บันทึกข้อมูลแล้ว")
        } catch {
            print("ไม่สามารถบันทึกข้อมูลได้")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
