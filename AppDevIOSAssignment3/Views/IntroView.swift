//
//  IntroView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 15/5/2023.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image("IntroCartoon")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Welcome to StuToDo")
                    .font(.system(
                        .largeTitle,
                        design: .rounded
                    ) .weight(.light)
                    )
                
                Spacer()
                
                
                NavigationLink{
                    DailyView()
                } label: {
                    Text("Tap to continue")
                }
                .tint(Color("MainPurple"))
                .frame(alignment: .bottom)
                .font(.system(
                    .body,
                    design: .rounded
                ) .weight(.bold)
                )
            }
        } .navigationBarBackButtonHidden(true) 
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
