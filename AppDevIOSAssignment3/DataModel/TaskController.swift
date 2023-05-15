//
//  NewTask.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 11/5/2023.
//

import Foundation
import CoreData

class TaskController: ObservableObject {
    let container = NSPersistentContainer(name: "TaskDataModel")
    
    init(){
        container.loadPersistentStores{desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }}
    }
        
    func saveTask(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Task data saved")
        } catch {
            print("Task data could not be saved")
        }
    }
    
    func addTask(desc: String, date: Date, context: NSManagedObjectContext){
        let task = Task(context: context)
        task.id = UUID()
        task.date = date
        task.desc = desc
        task.completion = false
        print("date now: \(Date.now.formatted(.dateTime.day().month().year()))")
        //context label = context or else have to copy try-catch
        saveTask(context: context)
    }
    
    func editTask(task: Task, desc: String, date: Date, context: NSManagedObjectContext){
        task.date = date
        task.desc = desc
        task.completion = false
        
        saveTask(context: context)
    }
}
