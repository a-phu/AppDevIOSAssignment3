//
//  Reminder.swift
//  AppDevIOSAssignment3
//
//  Created by  Seng Mun Mai on 14/5/2023.
//

import SwiftUI

struct Reminder: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct ReminderData: Identifiable{
    var id = UUID().uuidString
    var remind: [Reminder]
    var remindDate: Date
}

func getSampleDate(offset: Int)->Date{
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

// Reminders
var tasks: [ReminderData] = [

    ReminderData(remind: [
    
        Reminder(title: "Review Lecture slide"),
        Reminder(title: "Assignment due"),
        Reminder(title: "Grocery Shopping")
    ], remindDate: getSampleDate(offset: -15)),
   
    ReminderData(remind: [
        Reminder(title: "Friend's Birthday")
    ], remindDate: getSampleDate(offset: 4)),
    
    ReminderData(remind: [
        Reminder(title: "Group meeting")
    ], remindDate: getSampleDate(offset: 6)),
    
    ReminderData(remind: [
        Reminder(title: "Lecture Class"),
        Reminder(title: "Tutorial Class")
    ], remindDate: getSampleDate(offset: 10)),
    
    ReminderData(remind: [
        Reminder(title: "Go to Library")
    ], remindDate: getSampleDate(offset: 26)),
    
    ReminderData(remind: [
        Reminder(title: "Watch Cooking show"),
        Reminder(title: "Try new recipe")
    ], remindDate: getSampleDate(offset: 22)),
    
    ReminderData(remind: [
        Reminder(title: "Grocerry Shopping")
    ], remindDate: getSampleDate(offset: 8)),
]

