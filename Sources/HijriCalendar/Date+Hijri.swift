//
//  Date+Hijri.swift
//
//
//  Created by Mohamed Shemy on 17/02/2024.
//

import Foundation

extension Date {
    
    public var hijri: HijriDate {
        HijriCalendar.toHijriDate(from: self)
    }
}
