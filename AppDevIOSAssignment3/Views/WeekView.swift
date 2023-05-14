//
//  WeeklyCalendarView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 14/5/2023.
//

import SwiftUI

class WeekView: ObservableObject {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var task: FetchedResults<Task>
    
    
    //CURRENT WEEK
    @Published var currentWeek: [Date] = []
    
    //CURRENT DAY
    @Published var currentDay: Date = Date.now
    
    //FILTER SELECTED DAY'S TASKS
    @Published var filteredTasks: [Task]?
    
    
    init(){
        fetchCurrentWeek()
//        filterTodayTasks()
    }
    
    //FILTER TODAY'S TASKS
//    func filterTodayTasks(){
//        DispatchQueue.global(qos: .userInteractive).async {
//            let calendar = Calendar.current
//            
//            let filtered = storedTasks.filter{
//                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
//            }
//            
//            DispatchQueue.main.async {
//                withAnimation{
//                    self.filteredTasks = filtered
//                }
//            }
//        }
//    }
//    
    
    func fetchCurrentWeek(){
        let today = Date.now
//        print("today's date \(today)")
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
//        print("this week \(String(describing: week))")
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
//        print("first week day: \(firstWeekDay)")
        
        //start from 0 to get today's date
        (0...6).forEach {day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                print("weekday \(weekday)")
                currentWeek.append(weekday)
            }
        }
    }
    
    
    
    //EXTRACT DAY
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    //CHECK IF CURRENT DATE IS TODAY
    func isToday(date: Date)-> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}

//struct WeeklyCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeeklyCalendarView()
//    }
//}
