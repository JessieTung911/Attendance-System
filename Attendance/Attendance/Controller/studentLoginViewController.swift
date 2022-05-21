//
//  studentLoginViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/15.
//
import UIKit
import Foundation

class studentLoginViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var studentIDTextField: UITextField!
     
    var result = false
    
    @IBOutlet weak var errorMessageTextLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageTextLabel.text = ""
        
    }
    
    // This function can print error message if the input is incorrect.
    @IBAction func studentLogin(_ sender: Any) {
        if !result {
            errorMessageTextLabel.text = "Please check your input!"
        }
    }
    
    // This function can check whether the student exists.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        result =  appDelegate.findStudent(studentID: Int(studentIDTextField.text ?? "0")!, password: passwordTextField.text!)
        return result
    }
    
    // This function can pass data to the next page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMainStudent" {
            if let destination = segue.destination as? mainStudentViewController {
                destination.studentID = Int(studentIDTextField.text ?? "0")!
            }
        }
    }
}
