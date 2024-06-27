//
//  Habit.swift
//  Slow Track
//
//  Created by Tyler Steele on 5/20/24.
//

import Foundation
import SwiftData
import UIKit
import SwiftUI

@Model
final class Habit {
    @Attribute(.unique) let id: UUID
    var title: String
    var motivation: String
    var days: [Day]
    var color: AllowedColor
    
    static let `default` = Habit()
    
    init(id: UUID = UUID(), title: String = "", motivation: String = "", color: AllowedColor = AllowedColor.allCases.randomElement()!, days: [Day] = []) {
        self.id = id
        self.title = title
        self.motivation = motivation
        self.color = color
        self.days = days
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
