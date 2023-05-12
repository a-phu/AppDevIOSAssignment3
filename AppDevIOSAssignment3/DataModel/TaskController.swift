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
    
    func addTask(description: String, context: NSManagedObjectContext){
        let task = Task(context: context)
        task.id = UUID()
        task.date = Date()
        task.desc = description
        task.completion = false
        
        //context label = context or else have to copy try-catch
        saveTask(context: context)
    }
    
    func editTask(task: Task, description: String, context: NSManagedObjectContext){
        task.date = Date()
        task.desc = description
        task.completion = false
        
        saveTask(context: context)
    }
}
