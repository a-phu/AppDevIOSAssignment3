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
    
    var body: some View {
        
        Form{
            Section{
                TextField("Enter description of task:", text: $desc)
            }
            
            HStack{
                Spacer()
                Button("Add new task"){
                    TaskController().addTask(description: desc, context: managedObjContext)
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
