//
//  mainViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/10.
//

import Foundation
import UIKit

class mainViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    var courses: [Course]?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = name!
        courses = appDelegate.getCourses()
    }

    // This function can direct the next page based on the condition. If the codes have already created, next page will be the list of codes. Otherwises, the user needs to enter the number of students to create codes.
    @IBAction func performCode(_ sender: Any) {
        if appDelegate.getNumCodes(courseName: name!) == 0 {
            self.performSegue(withIdentifier: "segueToNumStudent", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "segueToCodeList", sender: nil)
        }
    }
    
    // This function can delete the corresponding course.
    @IBAction func deleteCourse(_ sender: Any) {
        if (courses?.count ?? 0) != 0 {
            appDelegate.deleteCourse(courseName: self.name!)
            appDelegate.deleteCodeCourse(courseName: self.name!)
            appDelegate.deleteCourseAttendance(courseName: self.name!)
            self.performSegue(withIdentifier: "segueToCourse", sender: nil)
        }
    }
    
    // This function can pass data to its corresponding pages.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       if segue.identifier == "segueToCodeSetting" {
           if let destination = segue.destination as? codeSettingViewController {
               destination.cname = name!

           }
       } else if segue.identifier == "segueToNumStudent" {
           if let destination = segue.destination as? numStudentViewController {
               destination.name = name!
           }
       } else if segue.identifier == "segueToCodeList" {
           if let destination = segue.destination as? codeListViewController {
               destination.name = name!
               destination.noStudents = 3
           }
       } else {
           if let destination = segue.destination as? viewAttendanceViewController {
               destination.name = name!
           }
       }
    }
        
}
