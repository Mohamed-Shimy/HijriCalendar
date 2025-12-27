//
//  HijriDate.swift
//  HijriCalendar
//
//  Created by Mohamed Shimy on Thu 31 Dec 2020.
//  Copyright © 2020 Mohamed Shimy. All rights reserved.
//

import Foundation

public struct HijriDate {
    
    // MARK: - Properties
    
    private let calendar = HijriCalendar()
    
    public let day: Int
    public let month: Int
    public let year: Int
    
    public var isCurrentDay: Bool { calendar.isCurrentDay(self) }
    public var date: Date { HijriCalendar.toGregorianDate(from: self) }
    public var monthSymbol: String { calendar.monthSymbols[month - 1] }
    public var shortMonthSymbol: String { calendar.shortMonthSymbols[month - 1] }
    public var dayIndex: Int { calendar.weekDayIndex(from: self) }
    public var isFriday: Bool { dayIndex == 6 }
    public var isEmpty: Bool { false }
    
    // MARK: - init
    
    public init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
}

extension HijriDate {
    
    public init(_ date: Date = Date()) {
        let hijri = HijriCalendar.toHijriDate(from: date)
        self.init(
            day: hijri.day,
            month: hijri.month,
            year: hijri.year)
    }
}

extension HijriDate {
    
    public static var current: HijriDate { HijriDate() }
}

// MARK: - Hashable

extension HijriDate: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(day)
        hasher.combine(month)
        hasher.combine(year)
    }
}

// MARK: - Equatable

extension HijriDate: Equatable {
    
    public static func == (lhs: HijriDate, rhs: HijriDate) -> Bool {
        return lhs.day == rhs.day
        && lhs.month == rhs.month
        && lhs.year == rhs.year
    }
    
    public static func == (lhs: HijriDate, rhs: Date) -> Bool {
        let hijri = rhs.hijri
        return lhs == hijri
    }
}

// MARK: - Adding

extension HijriDate {
    
    public func add(days: Int) -> Self {
        calendar.date(byAdding: .day, value: days, to: self)
    }
    
    public func add(months: Int) -> Self {
        calendar.date(byAdding: .month, value: months, to: self)
    }
    
    public func add(years: Int) -> Self {
        calendar.date(byAdding: .year, value: years, to: self)
    }
}

// MARK: - Navigation

extension HijriDate {
    
    public var nextDay: Self {
        let newDay = day + 1
        let monthDays = calendar.numberOfDays(in: month)
        if newDay > monthDays { return nextMonth }
        return .init(day: newDay, month: month, year: year)
    }
    
    public var previousDay: Self {
        let newDay = day - 1
        if newDay < 1 { return previousMonth }
        return .init(day: newDay, month: month, year: year)
    }
    
    public var nextMonth: Self {
        let newMonth = month + 1
        if newMonth > 12 { return nextYear }
        return .init(day: 1, month: newMonth, year: year)
    }
    
    public var previousMonth: Self {
        let newMonth = month - 1
        if newMonth < 1 { return previousYear }
        return .init(day: 1, month: newMonth, year: year)
    }
    
    public var nextYear: Self {
        .init(day: 1, month: 1, year: year + 1)
    }
    
    public var previousYear: Self {
        .init(day: 1, month: 12, year: max(year - 1, 1))
    }
}

// MARK: - CustomStringConvertible

extension HijriDate: CustomStringConvertible {
    
    public var description: String {
        String(format: "%02d/%02d/%lld", day, month, year)
    }
}
