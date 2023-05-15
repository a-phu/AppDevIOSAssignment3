//
//  LoginView.swift
//  AppDevIOSAssignment3
//
//  Created by Seng Mun Mai on 15/5/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationStack {
                ZStack{
                    VStack{
                        Text("Login")
                            .font(.system(
                                .largeTitle,
                                design: .rounded
                            ) .weight(.light)
                            ).padding()
                        Spacer()
                        
                        TextField("Username", text: $username)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.10))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongUsername))
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.10))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongPassword))
                        
                        NavigationLink{
                            DailyView()
                        } label: {
                            Text("Login")
                        }
                        .onTapGesture {
                            authenticateUser(username: username, password: password)
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color("MainPurple"))
                        .cornerRadius(10)
                        Spacer()
                        
                        Image("Rocket")
                        
                        Spacer()
                        
                    }
                }.navigationBarHidden(true)
                
            
        }
    }
        
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "Student1" {
            wrongUsername = 0
            if password.lowercased() == "123456" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
