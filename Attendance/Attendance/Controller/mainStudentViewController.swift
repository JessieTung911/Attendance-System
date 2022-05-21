//
//  mainStudentViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/15.
//

import UIKit
import Foundation

class mainStudentViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var courses: [Attendance]?
    var courseName: String? = nil
    var studentID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courses = appDelegate.getStudentCourse(id: studentID!)
        courseButtons()
    }
    
    // This function can create a button.
    func makeButtonWithText(text:String) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.system)
        myButton.frame = CGRect(x: 30, y: 30, width: 100, height: 100)
        myButton.layer.cornerRadius = 20
        myButton.backgroundColor = UIColor.white
        myButton.setTitle(text, for: .normal)
        myButton.titleLabel?.font =  UIFont(name: "Chalkboard SE", size: 20)
        myButton.setTitleColor(UIColor.blue, for: .normal)
        myButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
       return myButton
    }
    
    // This function can create multiple buttons.
    func courseButtons(){
        if (courses?.count ?? 0) > 0 {
            for course in courses! {
                let button = makeButtonWithText(text: course.courseName ?? "")
                mainStackView.addArrangedSubview(button)
                mainStackView.spacing = 20.0
            }
        }
        
    }
    
    // This function can get the button content and perform the segue.
    @objc func settingsButtonPressed(sender:UIButton) {
        courseName = sender.currentTitle ?? "No"
        self.performSegue(withIdentifier: "segueToEnterCodes", sender: self)
    }
    
    // This function can pass data to the next page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "segueToEnterCodes" {
           if let destination = segue.destination as? codeEnterViewController {
               destination.courseName = courseName!
               destination.studentID = studentID!
           }
       }
    }
    
    // This function can create a new course.
    @IBAction func addCourse(_ sender: Any) {
        var newCourse: String?
        let alert = UIAlertController(title: "Add Course", message: "Enter course code", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            newCourse = textField?.text
            let course = self.appDelegate.findStudentCourse(courseCode: newCourse!)
            if (course != "no") {
                self.appDelegate.addStudentAttendance(name: course, id: self.studentID!, times: 0)
                let button = self.makeButtonWithText(text: course)
                self.mainStackView.addArrangedSubview(button)
            }
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in}
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
