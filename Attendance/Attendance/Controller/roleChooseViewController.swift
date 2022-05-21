//
//  roleChooseViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/15.
//

import Foundation
import UIKit

class roleChooseViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        addStudent()
    }
    
    // This function can add students to the local disk.
    func addStudent() {
        if appDelegate.getStudents().count == 0 {
            appDelegate.storeStudent(studentID: 1, name: "Jessie", password: "12345")
            appDelegate.storeStudent(studentID: 2, name: "Jessica", password: "12345")
            appDelegate.storeStudent(studentID: 3, name: "Morris", password: "12345")
            appDelegate.storeStudent(studentID: 4, name: "Allen", password: "12345")
            appDelegate.storeStudent(studentID: 5, name: "Ella", password: "12345")
            appDelegate.storeStudent(studentID: 6, name: "Emily", password: "12345")
            appDelegate.storeStudent(studentID: 7, name: "Jason", password: "12345")
            appDelegate.storeStudent(studentID: 8, name: "Adon", password: "12345")
            appDelegate.storeStudent(studentID: 9, name: "Lin", password: "12345")
            appDelegate.storeStudent(studentID: 10, name: "Shane", password: "12345")
            appDelegate.storeStudent(studentID: 11, name: "Jayden", password: "12345")
        }
    }
}
