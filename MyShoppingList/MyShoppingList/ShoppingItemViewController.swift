//
//  ShoppingItemViewController.swift
//  MyShoppingList
//
//  Created by user on 9/30/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit

protocol ShoppingItemViewControllerDelegate {
    func addShoppingItem(newShoppingItem : ShoppingItem, newItem : Int)
    func cancelShoppingItem()
}

class ShoppingItemViewController: UIViewController {
    
    var delegate : ShoppingItemViewControllerDelegate?
    
    var myShoppingItem : ShoppingItem?
    var myNewItem : Int = 0
    
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductNumber: UITextField!
    @IBOutlet weak var txtProductUnitPrice: UITextField!
    
    @IBAction func saveMethod() {
        
        
        
        //order to hid keyboard 
        txtProductName.resignFirstResponder()
        txtProductNumber.resignFirstResponder()
        txtProductUnitPrice.resignFirstResponder()
        
        let trimProductName = txtProductName.text?.trimmingCharacters(in: .whitespaces)
        let trimProductNumber = txtProductNumber.text?.trimmingCharacters(in: .whitespaces)
        let trimProductUnitPrice = txtProductUnitPrice.text?.trimmingCharacters(in: .whitespaces)
        
        if ((trimProductName?.characters.isEmpty)! ||  (trimProductNumber?.characters.isEmpty)! || (trimProductUnitPrice?.characters.isEmpty)!){
            let alertController = UIAlertController(title: "MyShoppingList", message: "กรุณากรอกข้อมูล Shopping Item ให้ครบถ้วน",preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "ปิดหน้าต่าง", style: .cancel, handler: nil)
            let clearButton = UIAlertAction(title: "เคลียร์ข้อมูล",style: .default, handler: { (action) in
                self.txtProductName.text = ""
                self.txtProductNumber.text = ""
                self.txtProductUnitPrice.text = ""
            })
            
            alertController.addAction(cancelButton)
            alertController.addAction(clearButton)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            if myShoppingItem == nil {
                myShoppingItem = ShoppingItem()
            }
            
            myShoppingItem?.shoppingProductName = txtProductName.text!
            myShoppingItem?.shoppingProductNumber = Int(txtProductNumber.text!)!
            myShoppingItem?.shoppingProductUnitPrice = Double(txtProductUnitPrice.text!)!
            
            
            delegate?.addShoppingItem(newShoppingItem: myShoppingItem!, newItem : myNewItem)
        }
    }
    
    @IBAction func cancelMethod() {
        delegate?.cancelShoppingItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let v = myShoppingItem {
            txtProductName.text = v.shoppingProductName
            txtProductNumber.text = "\(v.shoppingProductNumber)"
            txtProductUnitPrice.text = "\(v.shoppingProductUnitPrice)"
        }
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
