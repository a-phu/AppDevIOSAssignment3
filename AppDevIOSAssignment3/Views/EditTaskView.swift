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
    @State private var date = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("\(task.desc!)", text: $desc)
                    .onAppear{
                        desc = task.desc!
                    }
                VStack(alignment: .leading){
                    HStack{
                        Text("Enter due date:")
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.date]).labelsHidden()
                    }
                }
                HStack{
                    Spacer()
                    Button("Submit"){
                        TaskController().editTask(task: task, desc: desc, date: date, context: managedObjContext)
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
}





//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView(task: task)
//    }
//}
