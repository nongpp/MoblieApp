//
//  StudentListTableViewController.swift
//  RateMyStudentDB
//
//  Created by user on 10/28/2560 BE.
//  Copyright © 2560 PP. All rights reserved.
//

import UIKit
import CoreData

class StudentListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var myStudentList : [Student] = []
    
    var myFilteredStudentList : [Student] = []
    let mySearchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RateMyStudentDB"
        
        mySearchController.searchResultsUpdater = self
        mySearchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = mySearchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func filterStudentContentForSearchText(searchText: String) {
        myFilteredStudentList = myStudentList.filter({myStudent in return myStudent.StudentName.contains(searchText)})
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterStudentContentForSearchText(searchText: mySearchController.searchBar.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myStudentList.removeAll()
        
        let myAppDelegate = UIApplication.shared.delegate as!AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentTB")
        
        do {
            let myFetchResults = try myContext.fetch(myFetchRequest)
            if myFetchResults.count > 0 {
                for myResult in myFetchResults as! [NSManagedObject] {
                    let myStudentName = myResult.value(forKey: "studentName") as! String
                    let myStudentRatingScore = myResult.value(forKey: "studentRatingScore") as! Int
                    let myStudentImage = UIImage(data: myResult.value(forKey: "studentImage") as! Data)!
                    let myStudentInfo = Student(StudentName: myStudentName, StudentRatingScore: myStudentRatingScore, StudentImage: myStudentImage)
                    myStudentList.append(myStudentInfo)
                }
            }
        } catch let error as NSError {
            print (error.description)
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if ((mySearchController.isActive) && (mySearchController.searchBar.text != "")) {
            return myFilteredStudentList.count
        }
        return myStudentList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentTableViewCell
        
        let myStudent : Student
        
        if mySearchController.isActive && mySearchController.searchBar.text != "" {
            myStudent = myFilteredStudentList[indexPath.row]
        } else {
            myStudent = myStudentList[indexPath.row]
        }
        
        cell.lblName.text = myStudent.StudentName
        cell.lblScore.text = "\(myStudent.StudentRatingScore)"
        cell.myImage.image = myStudent.StudentImage
        
        /*
        cell.lblName.text = myStudentList[indexPath.row].StudentName
        cell.lblScore.text = "\(myStudentList[indexPath.row].StudentRatingScore)"
        cell.myImage.image = myStudentList[indexPath.row].StudentImage
         */
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentTB")
            myFetchRequest.returnsObjectsAsFaults = false
            
            let myPredicate = NSPredicate(format: "studentName == %@", myStudentList[indexPath.row].StudentName)
            myFetchRequest.predicate = myPredicate
            
            do{
                let myFetchResults = try myContext.fetch(myFetchRequest)
                if myFetchResults.count > 0 {
                    let myReesult = myFetchResults.first as!NSManagedObject
                    myContext.delete(myReesult)
                }
            } catch let error as NSError {
                print(error.description)
            }
            
            myStudentList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do{
                try myContext.save()
            } catch let error as NSError {
                print(error.description)
            }
        } 
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rateSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let myRateStudentVC = segue.destination as!RateStudentViewController
            
            if ((mySearchController.isActive) && (mySearchController.searchBar.text != "")) {
                myRateStudentVC.theStudent = myStudentList[indexPath.row]
            } else {
                myRateStudentVC.theStudent = myStudentList[indexPath.row]
            }
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
