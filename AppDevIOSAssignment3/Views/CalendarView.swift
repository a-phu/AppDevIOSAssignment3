//
//  CalendarView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 11/5/2023.
//

import SwiftUI

//parent view (where i'm getting the date from)
struct CalendarView: View {
    @Environment(\.dismiss) var dismiss
    @State private var date: Date = Date()
    //give constants to selectedDate
    @Binding var selectedDate: Date
    

    var body: some View {
        
        VStack{
            DatePicker(
                "Start Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .onChange(of: date){ newDate in
                print("date selected: \(newDate)")
                self.selectedDate = newDate
            }
            
             
            HStack{
                Spacer()
                Button("Return"){
                    dismiss()
                }
                Spacer()
            }
        }
        
        
    }
    
    
    private func printDate(){
        print("date selected \($date)")
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(selectedDate: .constant(Date.now))
    }
}
