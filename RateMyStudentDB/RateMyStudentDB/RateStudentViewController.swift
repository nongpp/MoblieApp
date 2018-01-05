//
//  RateStudentViewController.swift
//  RateMyStudentDB
//
//  Created by user on 10/28/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit
import CoreData

class RateStudentViewController: UIViewController {
    
    var theStudent : Student = Student()

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblRatingScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = theStudent.StudentName
        imgView.image = theStudent.StudentImage
        lblRatingScore.text = "\(theStudent.StudentRatingScore)"
    }
    
    @IBAction func addScoreMethod() {
        theStudent.addRatingScore(ratingScore: 10)
        saveStudentRecord()
    }
    @IBAction func minusScoreMethod() {
        theStudent.minusRatingScore(ratingScore: 10)
        saveStudentRecord()
    }
    @IBAction func resetScoreMethod() {
        theStudent.resetRatingScore()
        saveStudentRecord()
    }
    
    func saveStudentRecord() -> Void {
        let myAppDelegate = UIApplication.shared.delegate as!AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentTB")
        
        let myPredicate = NSPredicate(format: "studentName == %@", theStudent.StudentName)
        myFetchRequest.predicate = myPredicate
        do {
            let myFetchResults = try myContext.fetch(myFetchRequest)
            if myFetchResults.count > 0 {
                let myResult = myFetchResults.first as!NSManagedObject
                
                myResult.setValue(theStudent.StudentName, forKey: "studentName")
                myResult.setValue(theStudent.StudentRatingScore, forKey: "studentRatingScore")
                let theImageData = UIImagePNGRepresentation(theStudent.StudentImage)! as NSData
                myResult.setValue(theImageData, forKey: "studentImage")
            }
        } catch let error as NSError {
            print(error,description)
        }
        
        do {
            try myContext.save()
        } catch let error as NSError {
            print(error.description)
        }
        
        navigationController?.popViewController(animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

