//
//  DailyView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 15/5/2023.
//

import SwiftUI

struct DailyView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var taskList: FetchedResults<Task>
    @State var selectedDate: Date = Date.now
    @Namespace var animation
    @StateObject var weekView: WeekView = WeekView()
    @State private var showingAddNewTaskView = false
    @State private var showingCalendarView = false
    
    
    init(){
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                HeaderView()
//                WeeklyView()
                DailyTasksView()
                //                NoTasksView()
                Spacer()
                VStack(alignment: .trailing) {
                    HStack (spacing: 30){
                        Spacer()
                               .frame(width: 230)
                        //ADD NEW TASK BUTTON
                        Button {
                            // action
                            showingAddNewTaskView.toggle()
                        } label: {
                            Image("AddButton")
                                .resizable()
                                .frame(width: 75, height: 75)
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                
            }
            //TOOLBAR
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button {
                            //                        showingCalendarView.toggle()
                        } label: {
                            Image(systemName: "house.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.foregroundColor(.black)
                        Button {
                            showingCalendarView.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.foregroundColor(.black)
                        Button {
                            
                        } label: {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.foregroundColor(.black)
                        
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton().foregroundColor(.black)

                }

                
            } .sheet(isPresented: $showingAddNewTaskView ){
                AddNewTaskView()
            }
            .sheet(isPresented: $showingCalendarView ){
                CalendarView(selectedDate: self.$selectedDate).onAppear{
                    print("calendar view appeared")
                }
            }
            
            
        }

        
    }
    
    private func WeeklyView() -> some View{
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
        }
    }
    
    private func HeaderView() -> some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5){
                Text("Today's to-do").font(.largeTitle).foregroundColor(.black)
                Text(selectedDate.formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
                
            }
            .hLeading()
        }
        .background(Color.white)
        .padding()
    }
    
    private func NoTasksView() -> some View{
        
            VStack(alignment: .center, spacing: 20){
                Spacer()
                       .frame(height: 100)
                HStack{
                    Image("HighFive")
                }
                VStack{
                    Text("No tasks left for today")
                        .font(
                            .title2
                                .weight(.bold)
                        )
                    Text("Tap + to add a new task")
                }
                
            }
        
        .background(Color.white)
        .padding()
    }
    
    private func TaskCardView(task: Task) -> some View{
        HStack (alignment: .top, spacing: 30){
            
//            VStack(spacing: 10){
////                Circle()
////                    .fill(.black)
////                    .frame(width: 15, height: 15)
////                    .background(
////                        Circle()
////                            .stroke(.black, lineWidth: 1)
////                            .padding(-3)
////                    )
//
//            }
            VStack{
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.desc!)
                    }
                    Spacer()
                    Text("\(task.date!.formatted(.dateTime.day().month().year()) )").foregroundColor(.gray).italic()
                }.background(Color.pink)
            }
            
        }
        .hLeading()
        .padding(.horizontal)
    }
    
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
    
    private func DailyTasksView() -> some View{
        
        VStack(alignment: .leading, spacing: 18){
            
            List{
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
            
        }.listStyle(.plain)
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}
