//
//  WeeklyCalendarView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 14/5/2023.
//

import SwiftUI

class WeekView: ObservableObject {
    //    var body: some View {
    //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    //    }
    
    //CURRENT WEEK
    @Published var currentWeek: [Date] = []
    
    //CURRENT DAY
    @Published var currentDay: Date = Date.now
    
    init(){
//        self.currentWeek = []
//        self.currentDay = Date.now
//        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek(){
        let today = Date.now
        print("today's date \(today)")
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (1...7).forEach {day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
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
