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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var task: FetchedResults<Task>
    
    //hide AddNewTaskView
    @State private var showingAddNewTaskView = false
    @State private var showingCalendarView = false
    
    @State var selectedDate: Date = Date.now
//    @State var weekView: WeekView = WeekView()
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .center){
                Section {
                    //CURRENT WEEK VIEW
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack(spacing: 10){
//                            ForEach(weekView.currentWeek, id: \.self){day in
//                                VStack(spacing: 10){                                    Text(weekView.extractDate(date: day, format: "EEE"))
//                                        .font(.system(size: 14))
//                                        .fontWeight(.semibold)
//                                    Text(weekView.extractDate(date: day, format: "dd"))
//                                        .font(.system(size: 14))
//                                    Circle()
//                                        .fill(.white)
//                                        .frame(width: 8, height: 8)
//                                        .opacity(weekView.isToday(date: day) ? 1 : 0)
//                                }
//                                .foregroundColor(.white)
//                                .frame(width: 45, height: 90)
//                                .background(
//                                    ZStack{
//                                        Capsule()
//                                            .fill(.black)
//                                    }
//                                )
//                                
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
                } header: {
                    //HEADER FOR PROFILE
                    headerView()
                }
            }.padding()
            
            VStack(alignment: .leading){
                List {
                    ForEach(task){
                        task in
                        if task.date!.formatted(.dateTime.day().month().year())
                            == selectedDate.formatted(.dateTime.day().month().year()) {
                            NavigationLink(destination: EditTaskView(task: task)){
                                HStack{
                                    VStack(alignment: .leading, spacing: 6){
                                        Text(task.desc!).bold()
                                    }
                                    Spacer()
                                    Text("\(task.date!.formatted(.dateTime.day().month().year()) )").foregroundColor(.gray).italic()
                                }
                            }
                            
                        }
                        
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(.plain)
              
            }
//            .navigationTitle("today's to-do")
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
    
    private func headerView() -> some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5){
                Text(Date.now.formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
                Text("Today").font(.largeTitle)
            }
            .hLeading()
            
            Button{
                
            } label: {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
        }
//        .padding()
        .background(Color.white)
    }
    private func deleteTask(offsets: IndexSet){
        //pass
        withAnimation{
            offsets.map {
                //map to current position
                task[$0]
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
