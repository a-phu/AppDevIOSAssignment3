//
//  ContentView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 10/5/2023.
//

import SwiftUI
import CoreData

//child view - where i;m using the date
struct DailyTasksView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var taskList: FetchedResults<Task>
    
    //hide AddNewTaskView
    @State private var showingAddNewTaskView = false
    @State private var showingCalendarView = false
    
    @State var selectedDate: Date = Date.now
    @StateObject var weekView: WeekView = WeekView()
    @Namespace var animation
    
    var body: some View {
        NavigationStack{

            VStack(alignment: .center){
                Section {
                    //CURRENT WEEK VIEW
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(weekView.currentWeek, id: \.self){day in
                                VStack(spacing: 10){                                    Text(weekView.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    Text(weekView.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 14))
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(weekView.isToday(date: day) ? 1 : 0)
                                }
                                //FOREGROUND COLOUR
                                .foregroundStyle(weekView.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(weekView.isToday(date: day) ? .white : .black)
                                //CAPSULE SHAPE
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack{
                                        if weekView.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CurrentDay", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture{
                                    //UPDATING CURRENT DAY
                                    withAnimation{
                                        weekView.currentDay = day
                                    }
                                }
                            }
                        }
                        
                        .padding(.horizontal)
                    }
                } header: {
                    //HEADER FOR PROFILE
                    headerView()
                }
            }.padding()
            
            //TASK LIST
            VStack(alignment: .leading, spacing: 18){
                List {
                    ForEach(taskList){
                        task in
                        if task.date!.formatted(.dateTime.day().month().year())
                            == selectedDate.formatted(.dateTime.day().month().year()) {
                            NavigationLink(destination: EditTaskView(task: task)){
                                //TASK CARD
                                HStack{
                                    VStack(alignment: .leading, spacing: 6){
                                        Text(task.desc!).bold()
                                    }
                                    Spacer()
                                    Text("\(task.date!.formatted(.dateTime.day().month().year()) )").foregroundColor(.gray).italic()
                                }
                            }
                            
                        }
//                        else {
////                            ProgressView().offset(y: 100)
//                            Text("No tasks for selected date. Tap \"+\" to add a task.")
//                                .font(.system(size: 16))
//                                .fontWeight(.light)
//                                .offset(y:100)
//                        }
                        
                    }
                    .onDelete(perform: deleteTask)
//                    .onChange(of: weekView.currentDay) {
//                        selectedDate in weekView.filterTodayTasks()
//                    }
                }
                .listStyle(.plain)
              
                
            }

            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
    
                        Button {
                            showingCalendarView.toggle()
                        } label: {
                            Label("Show Calendar", systemImage: "calendar")
                        }
                        Button {
                            showingAddNewTaskView.toggle()
                        } label: {
                            Label("Add New Task", systemImage: "plus.circle")
                        }
                    }
                   
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddNewTaskView ){
                AddNewTaskView()
            }
            .sheet(isPresented: $showingCalendarView ){
                CalendarView(selectedDate: self.$selectedDate)
            }
        }
        .navigationViewStyle(.stack)

    }
    
    //HEADER
    private func headerView() -> some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5){
                Text(Date.now.formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
                Text("Today").font(.largeTitle)
            }
            .hLeading()
           
            VStack{
                Button{
                    
                } label: {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
            }
            
        }
//        .padding()
        .background(Color.white)
    }
    
    //DELETE TASKS
    private func deleteTask(offsets: IndexSet){
        //pass
        withAnimation{
            offsets.map {
                //map to current position
                taskList[$0]
            }
            //then find the current object and delete it
            .forEach(managedObjContext.delete)
            
            //save new context
            TaskController().saveTask(context: managedObjContext)
        }
    }
}
struct DailyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksView()
    }
}


//Helper functions for UI
extension View{
    
    func hLeading()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
