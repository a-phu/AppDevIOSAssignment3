//
//  AppDevIOSAssignment3App.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 10/5/2023.
//

import SwiftUI

@main
struct AppDevIOSAssignment3App: App {
    
    //inject task database
    @StateObject private var taskController = TaskController()
    
    var body: some Scene {
        WindowGroup {
//            DailyTasksView()
//                .environment(\.managedObjectContext, taskController.container.viewContext)
            IntroView().environment(\.managedObjectContext, taskController.container.viewContext)
        }
    }
}
