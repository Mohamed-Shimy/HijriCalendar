//
//  HijriMonth.swift
//  HijriCalendar
//
//  Created by Mohamed Shimy on Thu 31 Dec 2020.
//  Copyright © 2020 Mohamed Shimy. All rights reserved.
//

import Foundation

public struct HijriMonth {
    
    // MARK: - Properties
    
    private var calendar: HijriCalendar
        
    public let name: String
    public let number: Int
    public let year: Int
    public let numberOfDays: Int

    public var firstDayIndex: Int { calendar.weekDayIndex(from: firstDayDate) }
    public var gregorianMonths: [Int] { calendar.gregorianMonths(for: number, year: year) }
    public var weekdaySymbols: [String] { calendar.weekdaySymbols }
    public var firstDayDate: Date { calendar.firstDayDate(of: number, year: year) }
    public var lastDayDate: Date { calendar.lastDayDate(of: number, year: year) }
        
    public var nextMonth: HijriMonth {
        let newMonth = number + 1
        if newMonth > 12 { return nextYear }
        return HijriMonth(month: newMonth, year: year)
    }
    
    public var previousMonth: HijriMonth {
        let newMonth = number - 1
        if newMonth < 1 { return previousYear }
        return HijriMonth(month: newMonth, year: year)
    }
    
    public var nextYear: HijriMonth {
        HijriMonth(month: 1, year: year + 1)
    }
    
    public var previousYear: HijriMonth {
        HijriMonth(month: 12, year: Swift.max(year - 1, 1))
    }
    
    // MARK: - init
    
    public init(month: Int? = nil, year: Int? = nil) {
        calendar = HijriCalendar()
        self.year = year ?? calendar.year
        
        if let month = month,
           month >= 1, month <= 12 {
            number = month
        } else {
            number = calendar.month
        }
        
        name = calendar.monthSymbols[number - 1]
        numberOfDays = calendar.numberOfDays(in: number)
    }
}

// MARK: - init

extension HijriMonth {
    
    public init(date: HijriDate) {
        self.init(month: date.month, year: date.year)
    }
    
    public init(date: Date) {
        let hijri = date.hijri
        self.init(date: hijri)
    }
}

// MARK: - Equatable

extension HijriMonth: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.number == rhs.number && lhs.year == rhs.year
    }
}

// MARK: - Hashable

extension HijriMonth: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(year)
    }
}

// MARK: - Collection

extension HijriMonth: Collection, RandomAccessCollection {
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { numberOfDays }
    
    public func index(after i: Int) -> Int {
        Swift.min(i + 1, numberOfDays - 1)
    }
    
    public subscript(position: Int) -> HijriDate {
        assert(position < numberOfDays, "Number of \(number) month days is \(numberOfDays)")
        return HijriDate(day: position + 1, month: number, year: year)
    }
}

// MARK: - Pre-defined

extension HijriMonth {
    
    static var current: HijriMonth { HijriMonth() }
    
    static let muharram = HijriMonth(month: 1)
    static let safar = HijriMonth(month: 2)
    static let rabiʻI = HijriMonth(month: 3)
    static let rabiʻII = HijriMonth(month: 4)
    static let jumadaI = HijriMonth(month: 5)
    static let jumadaII = HijriMonth(month: 6)
    static let rajab = HijriMonth(month: 7)
    static let shaʻban = HijriMonth(month: 8)
    static let ramadan = HijriMonth(month: 9)
    static let shawwal = HijriMonth(month: 10)
    static let dhuʻlQiʻdah = HijriMonth(month: 11)
    static let dhuʻlHijjah = HijriMonth(month: 12)
}
