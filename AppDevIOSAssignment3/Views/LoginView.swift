//
//  LoginView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 14/5/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var name = ""
    
    var body: some View {
        VStack{
            Form{
                Section{
                    TextField("Enter your name:", text: $name)
                }
                
                HStack{
                    Spacer()
                    Button("Login"){
                        
                    }
                    Spacer()
                }
               
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
