//
//  Journey.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/20/24.
//

import Foundation
import SwiftData
import UIKit
import SwiftUI

@Model
final class Journey {
    @Attribute(.unique) var id: UUID
    var title: String
    var motivation: String
    private var _days: [Day] = []
    @Transient public var days: [Day] {
        get { _days }
        set {
            // TODO: Allow selection of hour and minute
            scheduleNotifications(for: newValue, at: 9, minute: 30)
            _days = newValue
        }
    }
    var color: AllowedColor
    var uiColor: UIColor {
        getUIColor(color: color)
    }
    
    
    static let `default` = Journey()
    
    // Because days has a getter and setter, it can't be set in the initializer. We don't set _days directly because we want the days setter side effect
    init(id: UUID = UUID(), title: String = "", motivation: String = "", color: AllowedColor = AllowedColor.allCases.randomElement()!) {
        self.id = id
        self.title = title
        self.motivation = motivation
        self.color = color
    }
    
    func scheduleNotifications(for days: [Day], at hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings {settings in
            let addRequests = {
                for day in days {
                    var dateComponents = DateComponents()
                    dateComponents.hour = hour
                    dateComponents.minute = minute
                    dateComponents.weekday = day.rawValue
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    
                    let content = UNMutableNotificationContent()
                    content.title = "It's time: \(self.title)"
                    content.body = self.motivation
                    content.sound = .default
                    
                    let identifier = "notification_\(day)"
                    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    
                    center.add(request) { error in
                        if let error = error {
                            print("Error scheduling for \(day): \(error.localizedDescription)")
                        }
                    }
                }
            }
            if settings.authorizationStatus == .authorized {
                addRequests()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequests()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}


enum AllowedColor: String, CaseIterable, Codable, Hashable, Identifiable {
    case Blue, Brown, Cyan, Green, Indigo, Mint, Orange, Pink, Purple, Red, Teal, Yellow
    var id: String { rawValue }
}

func getUIColor(color: AllowedColor) -> UIColor {
    switch color {
    case AllowedColor.Blue:
        return UIColor.systemBlue
    case AllowedColor.Brown:
        return UIColor.systemBrown
    case AllowedColor.Cyan:
        return UIColor.systemCyan
    case AllowedColor.Green:
        return UIColor.systemGreen
    case AllowedColor.Indigo:
        return UIColor.systemIndigo
    case AllowedColor.Mint:
        return UIColor.systemMint
    case AllowedColor.Orange:
        return UIColor.systemOrange
    case AllowedColor.Pink:
        return UIColor.systemPink
    case AllowedColor.Purple:
        return UIColor.systemPurple
    case AllowedColor.Red:
        return UIColor.systemRed
    case AllowedColor.Teal:
        return UIColor.systemTeal
    case AllowedColor.Yellow:
        return UIColor.systemYellow
    }
}
