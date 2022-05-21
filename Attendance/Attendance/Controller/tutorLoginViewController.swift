//
//  tutorLoginViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/15.
//

import Foundation
import UIKit

class tutorLoginViewController: UIViewController {
    
    @IBOutlet weak var loginID: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    var pass: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.text = ""
    }
    
    // This function can check login information.
    @IBAction func login(_ sender: Any) {
        if loginID.text == "123" && loginPasswordTextField.text == "123" {
            pass = true
            let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
        } else {
            errorMessageLabel.text = "Please check your login ID and password."
        }
    }
    
    // This function can perform segue if the condition matches. Otherwise, the segue will not perfrom.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return pass
    }
}
