//
//  ContentView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 10/5/2023.
//

import SwiftUI
import CoreData

struct DailyTasksView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var task: FetchedResults<Task>
    
    //hide AddNewTaskView
    @State private var showingAddNewTaskView = false
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                List {
                    ForEach(task){
                        task in
                        if task.date!.formatted(.dateTime.day().month().year())
                            == Date.now.formatted(.dateTime.day().month().year()) {
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
                //default list has default padding and is centred in middle
                .listStyle(.plain)
              
            }
            .navigationTitle("today's to-do")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        showingAddNewTaskView.toggle()
                    } label: {
                        Label("Add New Task", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddNewTaskView ){
                AddNewTaskView()
            }
        }
        //.navigationViewStyle(.stack)

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
