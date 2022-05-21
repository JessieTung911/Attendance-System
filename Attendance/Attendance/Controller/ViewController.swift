//
//  ViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/9.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var mainStackView: UIStackView!
    var courses: [Course]? = []
    var courseName: String? = nil
    @IBOutlet var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        courses = appDelegate.getCourses()
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
    
    // This function can create many buttons and add them to the subview.
    func courseButtons(){
        if (courses?.count ?? 0) > 0 {
            for course in courses! {
                let button = makeButtonWithText(text: course.courseName!)
                mainStackView.addArrangedSubview(button)
                mainStackView.spacing = 20.0
            }
        }
    }
    
    // This function can get the button text and perform the segue when the user clicks any button.
    @objc func settingsButtonPressed(sender:UIButton) {
        courseName = sender.currentTitle ?? "No"
        self.performSegue(withIdentifier: "segueToMain", sender: self)
        
    }
    
    // This function can pass the data to the next page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "segueToMain" {
           if let destination = segue.destination as? mainViewController {
               destination.name = courseName!
           }
       }
    }

    // This function can add the new button.
    @IBAction func addCourse(_ sender: Any) {
        var newCourse: String?
        let alert = UIAlertController(title: "Add Course", message: "Enter course name", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            newCourse = textField?.text
            self.appDelegate.storeCourse(name: newCourse!, code: "aaa", numTimes: 0)
            let button = self.makeButtonWithText(text: newCourse!)
            self.mainStackView.addArrangedSubview(button)
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in}
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}

