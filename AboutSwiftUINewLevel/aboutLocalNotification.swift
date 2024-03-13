//
//  aboutLocalNotification.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 24.04.2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "im goin baby on baby"
        content.sound = .default
        content.badge = 1
        
        // time
        
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 33
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 54.981295,
            longitude: 82.886031)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 300,
            identifier: UUID().uuidString)
        region.notifyOnExit = true // exit the location
        region.notifyOnEntry = true // entry the location
        
        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: timeTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct aboutLocalNotification: View {
    var body: some View {
        VStack{
            Button(action: {
                NotificationManager.instance.requestAuthorization()
            }) {
                Text("Get Permission")
                    .tint(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding()
            }
            
            Button(action: {
                NotificationManager.instance.scheduleNotification()
            }) {
                Text("Get Notification")
                    .tint(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding()
            }
            
            Button(action: {
                NotificationManager.instance.cancelNotification()
            }) {
                Text("Cancel Notification")
                    .tint(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct aboutLocalNotification_Previews: PreviewProvider {
    static var previews: some View {
        aboutLocalNotification()
    }
}
