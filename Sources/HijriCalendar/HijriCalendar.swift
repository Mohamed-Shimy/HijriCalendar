//
//  HijriCalendar.swift
//  HijriCalendar
//
//  Created by Mohamed Shimy on Thu 31 Dec 2020.
//  Copyright © 2020 Mohamed Shimy. All rights reserved.
//

import Foundation

public struct HijriCalendar: Sendable {
    
    // MARK: - Properties
    
    private var calendar: Calendar = .hijriUmmAlQura
    public var weekdaysPadding: Int
    public var identifier: Calendar.Identifier { calendar.identifier }
    public var timeZone: TimeZone { didSet { calendar.timeZone = timeZone } }
    public var locale: Locale? { didSet { calendar.locale = locale } }
    public var day: Int { calendar.component(.day, from: Date()) }
    public var month: Int { calendar.component(.month, from: Date()) }
    public var year: Int { calendar.component(.year, from: Date()) }
    public var date: HijriDate { HijriDate() }
    
    // MARK: - init
    
    public init(
        locale: Locale? = nil,
        timeZone: TimeZone = .current,
        weekdaysPadding: Int = 1
    ) {
        self.locale = locale
        self.timeZone = timeZone
        self.weekdaysPadding = weekdaysPadding
    }
    
    // MARK: - Methods
    
    public func numberOfDays(in month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        if let date = calendar.date(from: dateComponents),
           let range = calendar.range(of: .day, in: .month, for: date)
        {
            return range.count
        }
        return 0
    }
        
    public func firstDayDate(of month: Int, year: Int? = nil) -> Date {
        let hijriDate = HijriDate(day: 1, month: month, year: year ?? self.year)
        return Self.toGregorianDate(from: hijriDate)
    }
    
    public func lastDayDate(of month: Int, year: Int? = nil) -> Date {
        let day = numberOfDays(in: month)
        let hijriDate = HijriDate(day: day, month: month, year: year ?? self.year)
        return Self.toGregorianDate(from: hijriDate)
    }
    
    public func component(_ component: Calendar.Component, from date: Date) -> Int {
        calendar.component(component, from: date)
    }
    
    public func component(_ component: Calendar.Component, from date: HijriDate) -> Int {
        self.component(component, from: Self.toGregorianDate(from: date))
    }
    
    public func weekDayIndex(from date: HijriDate = .current) -> Int {
        return weekDayIndex(from: date.date)
    }
    
    public func weekDayIndex(from date: Date) -> Int {
        ((calendar.component(.weekday, from: date) + weekdaysPadding) - 1) % 7
    }
    
    public func gregorianMonths(for month: Int, year: Int? = nil) -> [Int] {
        let first = firstDayDate(of: month, year: year).month - 1
        let second = lastDayDate(of: month, year: year).month - 1
       return [first, second]
    }
    
    public func isCurrentDay(_ date: HijriDate) -> Bool {
         self.date == date
    }
}

extension HijriCalendar {
    
    public static let current = HijriCalendar(
        locale: .current,
        timeZone: .current
    )
}

// MARK: Symbols

extension HijriCalendar {
    
    public var monthSymbols: [String] { calendar.monthSymbols }
    
    public var weekdaySymbols: [String] { calendar.weekdaySymbols.shifted(by: -weekdaysPadding) }
    
    public var shortMonthSymbols: [String] { calendar.shortMonthSymbols }
    
    public var shortWeekdaySymbols: [String] { calendar.shortWeekdaySymbols.shifted(by: -weekdaysPadding) }
    
    public var veryShortMonthSymbols: [String] { calendar.veryShortMonthSymbols }
    
    public var standaloneMonthSymbols: [String] { calendar.standaloneMonthSymbols }
    
    public var veryShortWeekdaySymbols: [String] { calendar.veryShortWeekdaySymbols.shifted(by: -weekdaysPadding) }
    
    public var standaloneWeekdaySymbols: [String] { calendar.standaloneWeekdaySymbols.shifted(by: -weekdaysPadding) }
    
    public var shortStandaloneMonthSymbols: [String] { calendar.shortStandaloneMonthSymbols }
    
    public var shortStandaloneWeekdaySymbols: [String] { calendar.shortStandaloneWeekdaySymbols.shifted(by: -weekdaysPadding) }
    
    public var veryShortStandaloneMonthSymbols: [String] { calendar.veryShortStandaloneMonthSymbols }
    
    public var veryShortStandaloneWeekdaySymbols: [String] { calendar.veryShortStandaloneWeekdaySymbols.shifted(by: -weekdaysPadding) }
}

// MARK: Adding

extension HijriCalendar {
    
    public func date(
        byAdding components: DateComponents,
        to date: HijriDate,
        wrappingComponents: Bool = false
    ) -> HijriDate {
        let date = date.date
        let gDate = calendar.date(
            byAdding: components,
            to: date,
            wrappingComponents: wrappingComponents
        ) ?? Date()
        return Self.toHijriDate(from: gDate)
    }
    
    public func date(
        byAdding component: Calendar.Component,
        value: Int,
        to date: HijriDate,
        wrappingComponents: Bool = false
    ) -> HijriDate {
        let date = date.date
        let gDate = calendar.date(
            byAdding: component,
            value: value,
            to: date,
            wrappingComponents: wrappingComponents
        ) ?? Date()
        return Self.toHijriDate(from: gDate)
    }
}

// MARK: Conversion

extension HijriCalendar {
    
    public static func toGregorianDate(from date: HijriDate) -> Date {
        let sourceComponent = DateComponents(
            timeZone: .current,
            year: date.year,
            month: date.month,
            day: date.day)
        return Calendar.hijriUmmAlQura.date(from: sourceComponent) ?? Date()
    }
    
    public static func toHijriDate(from date: Date) -> HijriDate {
        let hijriComponent = Calendar
            .hijriUmmAlQura
            .dateComponents(
                [.day, .month, .year],
                from: date)
        let date = HijriDate(
            day: hijriComponent.day!,
            month: hijriComponent.month!,
            year: hijriComponent.year!)
        return date
    }
}
