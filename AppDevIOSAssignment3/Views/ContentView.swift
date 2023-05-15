//
//  ContentView.swift
//  ToDoList
//
//  Created by Bevan Liang on 13/5/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var textFieldText: String = ""
    let mycolor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    var body: some View {
        ScrollView {
            VStack {
                Label("Custom", systemImage: "pencil")
                TextField("Type something here!", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(mycolor))
                    .cornerRadius(10)
                
                Button(action:{
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
                }, label: {
                    Text("📖Study")
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.mint)
                        .cornerRadius(10)
                }).padding(5)
                Button(action: {
                }, label: {
                    Text("💪gym")
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.brown)
                        .cornerRadius(10)
                }).padding(5)
                Button(action: {
                }, label: {
                    Text("👨‍🍳Cook Dinner")
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }).padding(5)
                Button(action: {
                }, label: {
                    Text("🛒Grocery Shopping")
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }).padding(5)
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
