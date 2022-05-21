//
//  codeListViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/10.
//


import Foundation
import UIKit

class codeListViewController: UIViewController {
    var name: String?
    var noStudents: Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var codes:[Code] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = name!
        getCodesFromDB()
    }
    
    // This function can get created codes from the local disk.
    func getCodesFromDB(){
        if appDelegate.getNumCodes(courseName: name!) == 0 {
            while(noStudents! > 0){
                let rstring: String = randomString(Int.random(in: 3...5))
                appDelegate.storeCode(name: name!, code: String(rstring), codeID: Int(appDelegate.getNumAllCodes()+1))
                noStudents = noStudents! - 1;
            }
        }
        codes = appDelegate.getCodes(courseName:name!)
    }
    
    // This function can add some new codes.
    @IBAction func addStudents(_ sender: Any) {
        let alert = UIAlertController(title: "Add Students", message: "Enter the number of new students", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        var new = 0
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let text = alert?.textFields![0]
            let num = Int((text?.text!)!)
            if num != nil {
                new = num!
                while new > 0 {
                    self.update()
                    new -= 1
                }
            } else {
                let alertController = UIAlertController(title: "Error", message:
                        "Please enter correct input!!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in}
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // This function can delete all table content.
    @IBAction func deleteAllStudents(_ sender: Any) {
        let num = noStudents!
        for _ in 0...num {
            noStudents! = noStudents! - 1
            appDelegate.deleteAllCourseCodes(courseName: name!)
            getCodesFromDB()
            tableView.reloadData()
            }
            self.performSegue(withIdentifier: "segueToMainPage", sender: nil)
        }

    // This function can delete the number of codes.
    @IBAction func deleteStudents(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Students", message: "Enter the number", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }
        var del = 0

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [weak alert] (_) in
            let text = alert?.textFields![0]
            let num = Int((text?.text!)!)
            if num != nil {
                del = num!
                while del > 0 {
                    self.del()
                    del -= 1
                    self.getCodesFromDB()
                }
                self.tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "Error", message:
                        "Please enter correct input!!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in}
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // This function can delete a code from the local disk.
    func del() {
        appDelegate.deleteCode(courseName: name!, code:codes[codes.count-1].code ?? "")
        noStudents! = noStudents! - 1
    }
    
    // This function can add a code to the local disk.
    func update() {
        noStudents! = noStudents! + 1
        appDelegate.storeCode(name: name!, code: String(randomString(Int.random(in: 3...5))), codeID: Int(appDelegate.getNumAllCodes()+1))
        getCodesFromDB()
        tableView.reloadData()
    }
    
    // This function can pass data to the next page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "segueToMainPage" {
           if let destination = segue.destination as? mainViewController {
               destination.name = name!
           }
       }
    }
}

extension codeListViewController: UITableViewDelegate {
    // When the user select a row at certain index, the app does nothing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


extension codeListViewController: UITableViewDataSource {
    // This function can return the number of rows which should be displayed in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        codes.count
    }
    
    // This function can ask the data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "codeCell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row+1)
        cell.detailTextLabel?.text = codes[indexPath.row].code
        return cell
    }
    
    // This function can generate a code string.
    func randomString(_ length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomCharacters = (0..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        return randomString
    }
    
    
}

