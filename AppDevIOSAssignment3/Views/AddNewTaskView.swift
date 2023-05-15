//
//  NewTaskView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 11/5/2023.
//

import SwiftUI

struct AddNewTaskView: View {
    
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var desc = ""
    @State private var date = Date()
    
    var body: some View {
        //add cancel button 
        Form{
            Section{
                TextField("Enter description of task:", text: $desc)
                VStack(alignment: .leading){
                    HStack{
                        Text("Enter due date:")
                        Spacer()
                        DatePicker("Enter due date of task", selection: $date, displayedComponents: [.date]).labelsHidden()
                    }
                }
                
                
            }
            
            //add tags for uni - lecture, tutorial, assignment, quiz etc
            //allow users to choose due date
            
            HStack{
                Spacer()
                Button("Add new task"){
                    TaskController().addTask(desc: desc, date: date, context: managedObjContext)
                    dismiss()
                }
                Spacer()
            }
            HStack{
                Spacer()
                Button("Cancel"){
                    dismiss()
                }
                Spacer()
            }
            
        }
        
    }
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
    }
}
