//
//  ContentView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 10/5/2023.
//

import SwiftUI

struct DailyTasksView: View {
    
//    var links: [String] = ["NewTask", "Calendar"]
    
    var body: some View {
        VStack {
            Text("Welcome, user!")
                .multilineTextAlignment(.leading).border(Color.red, width: 3)
            
            //Show Tasks to-do
            
            NavigationStack{
                List{}
                    .border(Color.blue, width: 3)
                Spacer()
                HStack{
                    NavigationLink("NewTask"){
                        CreateNewTaskView()
                    }
                    NavigationLink("ViewCalendar"){
                        CalendarView()
                    }
                }
                .padding(.bottom)
               
            }
            .border(Color.orange, width: 3)
            
            
        }
        .padding()
    }
}
struct DailyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksView()
    }
}
