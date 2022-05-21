//
//  viewAttendenceViewController.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/10.
//

import Foundation
import UIKit
class viewAttendanceViewController: UIViewController {
    
    var name: String?
    @IBOutlet weak var nameLabel: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var attendances: [Attendance]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = name!
        attendances = appDelegate.findStudentAttendance(courseName: name!)
    }
}

extension viewAttendanceViewController: UITableViewDelegate {
    // When the user select a row at certain index, the app does nothing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension viewAttendanceViewController: UITableViewDataSource {
    // This function can return the number of rows which should be displayed in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendances?.count ?? 0
    }
    
    // This function can ask the data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath)
        let id = attendances?[indexPath.row].studentID ?? 0
        cell.textLabel?.text = appDelegate.findStudentName(id: Int(id))
        let attendanceTime = String(attendances?[indexPath.row].times ?? 0)
        let separate = " / "
        let courseTimes = String(appDelegate.findCourseTime(courseName: name!))
        cell.detailTextLabel?.text = attendanceTime + separate + courseTimes
        return cell
    }
}
