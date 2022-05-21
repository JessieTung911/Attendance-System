//
//  numStudentViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/10.
//

import Foundation
import UIKit
class numStudentViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var name: String?
    var pass: Bool = false
    var numStudents: String?
    @IBOutlet weak var numStudentTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = name!
        errorMessageLabel.text = ""
    }
    
    // This function can pass data (the number of students) to the next page.
    @IBAction func pressButton(_ sender: Any) {
        let num = Int(numStudentTextField.text!)
        if num != nil && (num ?? 0) > 0 {
            pass = true
            errorMessageLabel.text = "Valid Input! Generating Code!"
            numStudents = numStudentTextField.text
            appDelegate.updateCourseTimes(courseName: name!)
            let vc = storyboard?.instantiateViewController(withIdentifier: "codeListViewController") as! codeListViewController
            vc.name = name!
            vc.noStudents = Int(numStudents!)
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
        }
        else {
            errorMessageLabel.text = "Error! Not Valid Input!"
        }
    }

    // This function can check whether direct to the next page.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return pass
    }
}
