//
//  EditView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 12/5/2023.
//

import SwiftUI

struct EditTaskView: View {
    
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var task: FetchedResults<Task>.Element
    @State private var desc = ""
    
    var body: some View {
        Form {
            Section {
                TextField("\(task.desc!)", text: $desc)
                    .onAppear{
                        desc = task.desc!
                    }
                HStack{
                    Spacer()
                    Button("Submit"){
                        TaskController().editTask(task: task, description: desc, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
        
    }
}





//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView(task: task)
//    }
//}
