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
//    @FetchRequest(
//        sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
//        predicate: NSPredicate(format: "date >= %@ && date <= %@", Calendar.current.startOfDay(for: Date() - 86400) as CVarArg, Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)) var taskList: FetchedResults<Task>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var taskList: FetchedResults<Task>
    
    //hide AddNewTaskView
    @State private var showingAddNewTaskView = false
    @State private var showingCalendarView = false
//    @State private var predicate : NSPredicate
    
    
    @StateObject var weekView: WeekView = WeekView()
    @State var selectedDate: Date = Date.now
    @Namespace var animation
    
    var body: some View {
        NavigationStack{
            //CURRENT WEEK VIEW
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                Section {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(weekView.currentWeek, id: \.self){day in
                                VStack(spacing: 10){             Text(weekView.extractDate(date: day, format: "EEE"))
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
                                        selectedDate = day
                                    }
                                }
                            }
                        }

                    }
                } header: {
                    //HEADER FOR PROFILE
                    HeaderView()
                }
            }.padding()
            
            //TASK LIST
            VStack(alignment: .leading, spacing: 18){
                    
                
                    ForEach(taskList, id: \.self){
                        task in
                        if (task.date!.formatted(.dateTime.day().month().year())
                            == selectedDate.formatted(.dateTime.day().month().year()))
                        {
                            NavigationLink(destination: EditTaskView(task: task)){
                                //TASK CARD
                                TaskCardView(task: task)
                            }
                            
                        }
                        
                    }
                    .onDelete(perform: deleteTask)
            }

            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
    
                        Button {
                            showingCalendarView.toggle()
                        } label: {
                            Label("Show Calendar", systemImage: "calendar")
                        }.foregroundColor(.black)
                        Button {
                            showingAddNewTaskView.toggle()
                        } label: {
                            Label("Add New Task", systemImage: "plus.circle")
                        }.foregroundColor(.black)

                    }
                   
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton().foregroundColor(.black)

                }
                
            }
            .sheet(isPresented: $showingAddNewTaskView ){
                AddNewTaskView()
            }
            .sheet(isPresented: $showingCalendarView ){
                CalendarView(selectedDate: self.$selectedDate).onAppear{
                    print("calendar view appeared")
                }
            }
            Spacer()
        }
        .navigationViewStyle(.stack)

    }
    //TASK CARD VIEW
    func TaskCardView(task: Task) -> some View{
        HStack (alignment: .top, spacing: 30){
            
            VStack(spacing: 10){
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
            
            }
            VStack{
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.desc!)
                    }
                    Spacer()
                    Text("\(task.date!.formatted(.dateTime.day().month().year()) )").foregroundColor(.gray).italic()
                }
            }
            
        }
        .hLeading()
        .padding(.horizontal)
    }
    //HEADER
    private func HeaderView() -> some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5){
                Text(Date.now.formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
                Text("Today").font(.largeTitle).foregroundColor(.black)
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
    
    private func taskListIsEmpty(entity: String) -> Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let count  = try managedObjContext.count(for: request)
            return count == 0
        } catch {
            return true
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
