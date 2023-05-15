//
//  CalendarView.swift
//  AppDevIOSAssignment3
//
//  Created by  Seng Mun Mai on 14/5/2023.
//

import SwiftUI


struct CalendarView: View {
    @Environment(\.dismiss) var dismiss
    @State var currentDate: Date = Date()

    var body: some View {
        NavigationStack{

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20){
                    CustomDatePicker(currentDate: $currentDate)
                }
                .padding(.vertical)
            }
            .safeAreaInset(edge: .bottom) {
                HStack{
                    NavigationLink{
                        AddNewTaskView()
                    } label: {
                        Text("Create New Task")
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("MainPurple"),in: Capsule())
                    Button{
                        dismiss()
                    } label: {
                        Text("Return to Daily View")
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("MenuGray"),in: Capsule())
                }
                .padding(.horizontal)
                .padding(.top,10)
                .foregroundColor(.white)
            }
            
        }
        
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35){
            let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.system(
                            .largeTitle,
                            design: .rounded
                        ) .weight(.light)
                        )
                }
                Spacer(minLength: 0)
                Button {
                    withAnimation{
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Button {
                    
                    withAnimation{
                        currentMonth += 1
                    }
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 0){
                ForEach(days,id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns,spacing: 15) {
                ForEach(extractDate()) { value in
                    
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("MainPurple"))
                                .padding(.horizontal,8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                    }
                }
            }
            
            
            //TO-DO LIST
            VStack(spacing: 15){
                Text("To-do List")
                    .font(.title2)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.vertical,20)
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.remindDate, date2: currentDate)
                }){
                    ForEach(task.remind) { task in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)),style: .time).fontWeight(.bold)
                            Text(task.title)
                                .font(.title2).fontWeight(.light)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(
                            Color.gray
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                    }
                }
                else{Text("No tasks found")}
            }
            .padding()
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    //TASK CARD VIEW
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack{
            
            if value.day != -1{
                
                if let task = tasks.first(where: { task in
                    
                    return isSameDay(date1: task.remindDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.remindDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: task.remindDate, date2: currentDate) ? .white : Color("MainPurple"))
                        .frame(width: 8,height: 8)
                }else{
                    Text("\(value.day)")
                        .font(.title3)
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .padding(.vertical,9)
        .frame(height: 60,alignment: .top)
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func extraDate()->[String]{
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate) - 1
        let year = calendar.component(.year, from: currentDate)
        
        return ["\(year)",calendar.monthSymbols[month]]
    }
    
    func getCurrentMonth()->Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        return currentMonth
    }
    
    func extractDate()->[DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

extension Date {
    
    func getAllDates()->[Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

