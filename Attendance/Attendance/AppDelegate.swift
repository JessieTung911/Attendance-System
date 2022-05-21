//
//  AppDelegate.swift
//  Attendance
//
//  Created by Jieying Dong on 2022/5/9.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // This function can get all content from the local disk.
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // This function can add courses to the course table.
    func storeCourse(name: String, code: String, numTimes: Int) {
        let context = getContext()
        let course = NSEntityDescription.entity(forEntityName: "Course", in: context)
        let transc = NSManagedObject(entity: course!, insertInto: context)
        transc.setValue(name, forKey: "courseName")
        transc.setValue(code, forKey: "courseCode")
        transc.setValue(numTimes, forKey: "numTimes")
        saveContext()
    }
    
    // This funtion can get the course list from the course table.
    func getCourses() -> [Course] {
        var courses = [Course]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Course")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                let c = trans as! Course
                courses.append(c)
            }
        } catch {
            print("Error with request: \(error)")
        }
        return courses
    }
    
    // This function can delete the course in the course table.
    func deleteCourse(courseName: String) {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        deleteFetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("There was an error")
        }
    }
    
    // This function can delete the course in the course table.
    func findCourse(courseName: String) -> Course {
        var c: Course!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Course")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                c = trans as? Course
            }
        } catch  {
            print("Error with request: \(error)")
        }
        return c
        
    }
    
    // This function can update the course code set in the course table.
    func updateCourseCode(courseName: String, courseCode: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Course")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let course = trans as? Course {
                    if course.courseName == courseName {
                        course.courseCode = courseCode
                        saveContext()
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    // This function can store the new code to the code table.
    func storeCode(name: String, code: String, codeID: Int) {
        let context = getContext()
        let codeEntity = NSEntityDescription.entity(forEntityName: "Code", in: context)
        let transc = NSManagedObject(entity: codeEntity!, insertInto: context)
        transc.setValue(name, forKey: "courseName")
        transc.setValue(code, forKey: "code")
        transc.setValue(codeID, forKey: "codeID")
        saveContext()
    }
    
    // This function can count the number of codes in the code table.
    func getNumCodes(courseName: String) -> Int {
        var codes = [Code]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Code")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let code = trans as? Code {
                    if code.courseName == courseName {
                        let c = trans as! Code
                        codes.append(c)
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return codes.count
    }
    
    // This function can count the number of codes for the specific course.
    func getNumAllCodes() -> Int {
        var codes = [Code]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Code")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                let c = trans as! Code
                codes.append(c)
            }
        } catch {
            print("Error with request: \(error)")
        }
        return codes.count
    }
    
    // This function can get codes for the specific course in the code table.
    func getCodes(courseName: String) -> [Code] {
        var codes = [Code]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Code")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let code = trans as? Code {
                    if code.courseName == courseName {
                        let c = trans as! Code
                        codes.append(c)
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return codes
    }
    
    // This function can clear all codes for the specific course in the code table.
    func deleteAllCourseCodes(courseName: String) {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Code")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        deleteFetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("There was an error")
        }
    }
    
    // This function can delete a code in the code table.
    func deleteCode(courseName: String, code: String) {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Code")
        let predicate = NSPredicate(format:"courseName == %@ AND code == %@", courseName, code)
        deleteFetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("There was an error")
        }
    }
    
    // This function can update the course times in the code table.
    func updateCourseTimes(courseName: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Course")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let course = trans as? Course {
                    if course.courseName == courseName {
                        course.numTimes += 1
                        saveContext()
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    // This function can add a student to the student table.
    func storeStudent(studentID: Int, name: String, password: String) {
        let context = getContext()
        let student = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let transc = NSManagedObject(entity: student!, insertInto: context)
        transc.setValue(studentID, forKey: "studentID")
        transc.setValue(name, forKey: "name")
        transc.setValue(password, forKey: "password")
        saveContext()
    }
    
    // This function can get all students in the student table.
    func getStudents() -> [Student] {
        var students = [Student]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                let s = trans as! Student
                students.append(s)
            }
        } catch {
            print("Error with request: \(error)")
        }
        return students
    }
    
    // This function can find a specific student in the student table.
    func findStudent(studentID: Int, password: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        let predicate = NSPredicate(format:"studentID == \(studentID) AND password == %@", password)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let _ = trans as? Student{
                    return true;
                }else{
                    return false;
                }
            }
        } catch  {
            print("Error with request: \(error)")
        }
        return false
    }
    
    // This function can find codes in the course table.
    func findStudentCourse(courseCode: String) -> String {
        var c: Course!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Course")
        let predicate = NSPredicate(format:"courseCode == %@", courseCode)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                c = trans as? Course
            }
        } catch  {
            print("Error with request: \(error)")
        }
        if c == nil {
            return "no"
        } else {
            return c?.courseName ?? ""
        }
    }
    
    // This function can add a student in the attendance table.
    func addStudentAttendance(name: String, id: Int, times: Int){
        let context = getContext()
        let attendance = NSEntityDescription.entity(forEntityName: "Attendance", in: context)
        let transc = NSManagedObject(entity: attendance!, insertInto: context)
        transc.setValue(name, forKey: "courseName")
        transc.setValue(id, forKey: "studentID")
        transc.setValue(times, forKey: "times")
        saveContext()
    }
    
    // This function can find students in the attendance table.
    func getStudentCourse(id: Int) -> [Attendance] {
        var attendances = [Attendance]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Attendance")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let attendance = trans as? Attendance {
                    if attendance.studentID == id {
                        let a = trans as! Attendance
                        attendances.append(a)
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return attendances
    }
    
    // This function can delete all students in the attendance table.
    func deleteAllStudentCourse(id: Int) {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Attendance")
        let predicate = NSPredicate(format:"studentID == \(id)")
        deleteFetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("There was an error")
        }
    }
    
    // This function can delete the code in the code table.
    func findStudentCourseCode(courseName: String, code: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Code")
        let predicate = NSPredicate(format:"courseName == %@ AND code == %@", courseName, code)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let _ = trans as? Code {
                    return true;
                }else{
                    return false;
                }
               
            }
        } catch  {
            print("Error with request: \(error)")
        }
        return false
    }
    
    // This function can update the attendance time.
    func updateAttendanceTimes(courseName: String, studentID: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Attendance")
        let predicate = NSPredicate(format:"courseName == %@ and studentID == \(studentID)", courseName)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let attendance = trans as? Attendance {
                    if attendance.courseName == courseName && attendance.studentID == studentID {
                        attendance.times += 1
                        saveContext()
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    // This function can show the attendance time for the specific student.
    func findAttendancTime(id: Int) -> Int16 {
        var a: Attendance!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Attendance")
        let predicate = NSPredicate(format:"studentID == \(id)")
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                a = trans as? Attendance
            }
        } catch  {
            print("Error with request: \(error)")
        }
        return a.times
    }
    
    // This function can find attendance records for the specific course.
    func findStudentAttendance(courseName: String) -> [Attendance] {
        var attendances = [Attendance]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Attendance")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                if let attendance = trans as? Attendance {
                    if attendance.courseName == courseName {
                        let a = trans as! Attendance
                        attendances.append(a)
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return attendances
    }
    
    // This function can find student name in the student table.
    func findStudentName(id: Int) -> String {
        var s: Student!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        let predicate = NSPredicate(format:"studentID == \(id)")
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                s = trans as? Student
            }
        } catch  {
            print("Error with request: \(error)")
        }
        return s.name ?? " "
    }
    
    // This function can find course times for specific courses.
    func findCourseTime(courseName: String) -> Int16 {
        var c: Course!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Course")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for trans in searchResults as [NSManagedObject] {
                c = trans as? Course
            }
        } catch  {
            print("Error with request: \(error)")
        }
        return c.numTimes
    }
    
    // This function can delete all students attendance records for specific course.
    func deleteCourseAttendance(courseName: String) {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Attendance")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        deleteFetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("There was an error")
        }
    }
    
    // This function can delete all student code records for specific course.
    func deleteCodeCourse(courseName: String) {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Code")
        let predicate = NSPredicate(format:"courseName == %@", courseName)
        deleteFetch.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("There was an error")
        }
    }
    
    
 
}

