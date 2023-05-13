//
//  CalendarView.swift
//  AppDevIOSAssignment3
//
//  Created by Annabel Phu on 11/5/2023.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()

    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
