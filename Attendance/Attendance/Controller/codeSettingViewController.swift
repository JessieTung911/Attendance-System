//
//  codeSettingViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/10.
//
import UIKit
import Foundation

class codeSettingViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    var cname: String?
    
    var code: String?
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var updateMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNameLabel.text = cname!
        code = appDelegate.findCourse(courseName: cname ?? "").courseCode
        codeTextField.text = code ?? ""
        updateMessage.text = " "
        
    }
    
    // This function can save the new code set.
    @IBAction func saveCode(_ sender: Any) {
        let result = codeTextField.text ?? ""
        appDelegate.updateCourseCode(courseName: cname!, courseCode: result)
        updateMessage.text = "Update Successfully!"
    }
    
}
