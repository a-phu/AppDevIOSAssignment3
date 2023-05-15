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
    @State private var date = Date()
    @Namespace var animation
    @State private var showingAddNewTaskView = false
    @State private var showingCalendarView = false
    

    var body: some View {
        NavigationStack{
            VStack{
                HeaderView()
                DailyTasksView()
                Spacer()
                VStack(alignment: .trailing) {
                    HStack (spacing: 30){
                        Spacer()
                               .frame(width: 230)
                        //ADD NEW TASK BUTTON
                        Button {
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
                        EditButton().foregroundColor(.black)
                        Button {
                            showingCalendarView.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.foregroundColor(.black)
                    }
                }

                
            } .sheet(isPresented: $showingAddNewTaskView ){
                AddNewTaskView()
            }
            .sheet(isPresented: $showingCalendarView ){
                CalendarView().onAppear{
                }
            }
            
            
        }

        
    }
    
    private func HeaderView() -> some View{
        HStack(spacing: 15){
            VStack(alignment: .leading, spacing: 10){
                Text("Today's to-do").font(.largeTitle).foregroundColor(.black)
                DatePicker("Enter date", selection: $selectedDate, displayedComponents: [.date]).labelsHidden()

            }
            .hLeading()
        }
        .background(Color.white)
        .padding()
    }

    
    private func TaskCardView(task: Task) -> some View{
        HStack (alignment: .top, spacing: 30){
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
