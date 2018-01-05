//
//  ContactViewController.swift
//  MyContactList
//
//  Created by user on 9/16/2560 BE.
//  Copyright © 2560 IOSTON. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController,
UIPickerViewDataSource, UIPickerViewDelegate{
    
    var myContactInfo : ContactInformation = ContactInformation()
   
    let contactType = ["ครอบครัว", "เพื่อนสมัยเรียน", "เพื่อนร่วมงาน", "ลูกค้าและสถานประกอบการ"]
    let publicType = ["ส่วนตัว", "ที่ทำงาน"]
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var pickerViewContactType: UIPickerView!
    
    @IBAction func saveContactinforMethod() {
        let myContactType = contactType[pickerViewContactType.selectedRow(inComponent: 0)]
        let myPublicType = publicType[pickerViewContactType.selectedRow(inComponent: 1)]
        print("Contact Saved Successfully!!!!")
        print("ชื่อ-นามสกุล : \(txtName.text!)")
        print("ชื่อเล่น : \(txtNickName.text!)")
        print("เบอร์โทร : \(txtPhoneNumber.text!)")
        print("ประเภท Contact : \(myContactType)-\(myPublicType)")
    }
    
    @IBAction func clearContactinforMethod() {
        txtName.text = ""
        txtNickName.text = ""
        txtPhoneNumber.text = ""
        pickerViewContactType.selectRow(0, inComponent: 0, animated: true)
        pickerViewContactType.selectRow(0, inComponent: 1, animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return contactType.count
        }
        else{
            return publicType.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return contactType[row]
        }
        else{
            return publicType[row]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = myContactInfo.contactNickName
        txtName.text = myContactInfo.contactName
        txtNickName.text = myContactInfo.contactNickName
        txtPhoneNumber.text = myContactInfo.contactPhoneNumber
        
        pickerViewContactType.selectRow(myContactInfo.contactType, inComponent: 0, animated: true)
        pickerViewContactType.selectRow(myContactInfo.contactPublicType, inComponent: 1, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

