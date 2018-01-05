//
//  ViewController.swift
//  MyWebViewApp
//
//  Created by user on 11/18/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        let myURL = URL(string: "https://www.google.co.th/maps/place/True+Incube+Space")
        let myRequest = URLRequest(url: myURL!)
        myWebView.load(myRequest)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alertController = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) {
            (action) -> Void in
            exit(0)
        }
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

