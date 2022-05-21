//
//  codeEnterViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/15.
//

import Foundation
import UIKit

class codeEnterViewController: UIViewController {
    
    @IBOutlet weak var courseLabel: UILabel!
    var courseName: String?
    var code: String?
    var studentID: Int?
    @IBOutlet weak var codeLabel: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var sucessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseLabel.text = courseName!
        sucessLabel.text = ""
    }
    
    // This function can check whether codes exist and update the code.
    @IBAction func checkCode(_ sender: Any) {
        code = codeLabel.text
        if code != "" {
            let status = appDelegate.findStudentCourseCode(courseName: courseName!, code: code!)
            if status {
                appDelegate.updateAttendanceTimes(courseName: courseName!, studentID: studentID!)
                appDelegate.deleteCode(courseName: courseName!, code: code!)
                sucessLabel.text = "Mark attendance successfully!"
            } else {
                sucessLabel.text = "Error!"
            }
        }
        
    }
}
