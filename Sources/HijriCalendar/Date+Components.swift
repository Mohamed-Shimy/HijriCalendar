//
//  Date+Components.swift
//
//
//  Created by Mohamed Shemy on 17/02/2024.
//

import Foundation

extension Date {
    
    internal var day: Int {
        let result = getComponents(.day)
        return result.day ?? 1
    }
    
    internal var month: Int {
        let result = getComponents(.month)
        return result.month ?? 1
    }
    
    internal var year: Int {
        let result = getComponents(.year)
        return result.year ?? 1
    }
    
    internal func getComponents(
        _ component: Calendar.Component
    ) -> DateComponents {
        Calendar.gregorian
            .dateComponents([component], from: self)
    }
}
