//
//  BMICalculatorViewController.swift
//  BMICalculator
//
//  Created by user on 9/2/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBOutlet weak var txtViewResult: UITextView!
    
    func bmiResultInterpretation(bmiValue : Double) -> String {
        var result : String = "ค่า BMI = \(bmiValue) \n"
        
        if bmiValue >= 40.0 {
            result += "คุณเป็นโรคอ้วนขั้นสูงสุด กรุณาพบแพทย์ด่วน"
        } else if bmiValue >= 35.0 {
            result += "คุณเป็นโรคอ้วนระดับ 2 คุณเสี่ยงต่อการเกิดโรคที่มากับความอ้วน หากคุณมีรอบเอวมากกว่าเกณฑ์ปกติคุณจะเสี่ยงต่อการเกิดโรคสูง คุณต้องควบคุมอาหาร และออกกำลังกายอย่างจริงจัง"
        } else if bmiValue >= 28.5 {
            result += "คุณเป็นโรคอ้วนระดับ 1 และหากคุณมีรอบเอวมากกว่า 90 ซม.(ชาย) 80 ซมใ(หญิง) คุณจะมีโอกาสเกิดโรคความดัน เบาหวานสูง จำเป็นต้องควบคุมอาหาร และออกกำลังกาย"
        } else if bmiValue >= 23.5 {
            result += "น้ำหนักเกิน หากคุณมีกรรมพันธ์เป็นโรคเบาหวานหรือไขมันในเลือดสูงต้องพยายามลดน้ำหนักให้ดัชนีมวลกายต่ำกว่า 23"
        } else if bmiValue >= 18.5 {
            result += "น้ำหนักปกติ และมีปริมาณไขมันอยู่มนเกณฑ์ปกติมักจะไม่ค่อยมีโรคร้าย อุบัติการณ์ของโรคเบาหวาน ความดันโลหิตสูงต่ำกว่าผู้ที่อ้วนกว่านี้"
        } else {
            result += "น้ำหนักน้อยเกินไป ซึ่งอาจจะเกิดจากนักกีฬาที่ออกกำลังกายมาก และได้รับสารอาหารไม่เพียงพอ วิธีแก้ไขต้องรับประทานอาหารที่มีคุณภาพ และมีปริมาณพลังงานเพียงพอ และออกกำลังกายอย่างเหมาะสม"
        }
        
        return result
    }
    
    @IBAction func bmiCalculationMethod(_ sender: Any) {
        let myWeight = Double(txtWeight.text!)!
        let myHeight = Double(txtHeight.text!)! / 100.0
        let myBMIResult = myWeight / (myHeight * myHeight)
        txtViewResult.text = bmiResultInterpretation(bmiValue: myBMIResult)
        
        txtWeight.resignFirstResponder()
        txtHeight.resignFirstResponder()
    }
    
    @IBAction func clearContentMethod(_ sender: Any) {
        txtWeight.text = ""
        txtHeight.text = ""
        txtViewResult.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
