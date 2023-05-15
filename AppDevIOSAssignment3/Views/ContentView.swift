//
//  ContentView.swift
//  ToDoList
//
//  Created by Bevan Liang on 13/5/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var desc = ""
    @State private var date = Date()
    
    @State var textFieldText: String = ""
    let mycolor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    var body: some View {
        ScrollView {
            VStack {
                DatePicker("Enter due date of task", selection: $date, displayedComponents: [.date]).labelsHidden()
                
                Label("Custom", systemImage: "pencil")
                TextField("Type something here!", text: $desc)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(mycolor))
                    .cornerRadius(10)
                
                Button(action:{
                    TaskController().addTask(desc: desc, date: date, context: managedObjContext)
                    dismiss()
                }, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }).padding(5)
                
                Label("Quick choice", systemImage: "pencil.and.outline")

                Button(action: {
                    TaskController().addTask(desc: "Study", date: date, context: managedObjContext)
                    dismiss()
                }) {
                    Text("📖Study")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.mint)
                        .cornerRadius(10)
                }.padding(5)
                Button(action: {
                    TaskController().addTask(desc: "Gym", date: date, context: managedObjContext)
                    dismiss()
                }) {
                    Text("💪Gym")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.brown)
                        .cornerRadius(10)
                }.padding(5)
                Button(action: {
                    TaskController().addTask(desc: "Cook Dinner", date: date, context: managedObjContext)
                    dismiss()
                }) {
                    Text("👨‍🍳Cook Dinner")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }.padding(5)

                Button(action: {
                    TaskController().addTask(desc: "Grocery Shopping", date: date, context: managedObjContext)
                    dismiss()
                }) {
                    Text("🛒Grocery Shopping")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }.padding(5)

                }
                
            
        }
        .navigationTitle("Add an Item! 👏")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
    }
}
