//
//  Date.swift
//  HijriCalendar
//
//  Created by Mohamed Shimy on 18/01/2026.
//

import Foundation

public extension Date {
    
    init(day: Int?, month: Int?, year: Int?) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let result = Calendar.current.date(from: dateComponents) ?? Date()
        self.init(timeInterval: 0, since: result)
    }
    
    init(
        bySettingHour: Int,
        minute: Int = 0,
        second: Int = 0
    ) {
        self = Calendar.current.date(
            bySettingHour: bySettingHour,
            minute: minute,
            second: second,
            of: Date()
        ) ?? Date()
    }
}

public extension Date {
    
    static var current: Date { Date() }
    
    static var locale: Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        return Calendar.current.date(
            byAdding: .second,
            value: Int(timeZoneOffset),
            to: nowUTC
        ) ?? Date()
    }
    
    var floatTime: Double {
        Double(hour) + (Double(minute) / 60.0) + (Double(second) / 3600.0)
    }
    
    var isCurrentDay: Bool {
        let current = Date()
        return current.day == day && current.month == month && current.year == year
    }
    
    var numberOfMonthDays: Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    var nextDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var previousDay: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
 
public extension Date {
    
    func bySetting(hour: Int, minute: Int = 0, second: Int = 0) -> Date {
        Calendar.current.date(
            bySettingHour: hour,
            minute: minute,
            second: second,
            of: self
        ) ?? self
    }
    
    func bySetting(_ component: Calendar.Component, value: Int) -> Date {
        Calendar.current.date(bySetting: component, value: value, of: self) ?? self
    }
    
    func byAdding(_ component: Calendar.Component, value: Int) -> Date {
        Calendar.current.date(byAdding: component, value: value, to: self) ?? self
    }
}

public extension Date {
    
    var second: Int { components(for: [.second]).second ?? 0 }
    
    var minute: Int { components(for: [.minute]).minute ?? 0 }
    
    var hour: Int { components(for: [.hour]).hour ?? 0 }
    
    var weekday: Int { components(for: [.weekday]).weekday ?? 0 }
        
    var day: Int { components(for: [.day]).day ?? 1 }
    
    var month: Int { components(for: [.month]).month ?? 1 }
    
    var year: Int { components(for: [.year]).year ?? 1 }
    
    func components(for components: Set<Calendar.Component>) -> DateComponents {
        let calendar = Calendar.current
        let result = calendar.dateComponents(components, from: self)
        return result
    }
}

public extension Date {
    
    var daySymbol: String { string(with: "EEEE") }
    
    var shortDaySymbol: String { string(with: "EEE") }
    
    var monthSymbol: String { string(with: "MMMM") }
    
    var shortMonthSymbol: String { string(with: "MMM") }
    
    func string(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = .current
        return formatter.string(from: self)
    }
}
