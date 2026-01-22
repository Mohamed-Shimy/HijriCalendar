//
//  Array+Shifted.swift
//
//
//  Created by Mohamed Shimy on 17/02/2024.
//

import Foundation

extension Array {
    
    public func shifted(by distance: Int = 1) -> [Element] {
        let offsetIndex =
        if distance >= 0 {
            self.index(
                startIndex,
                offsetBy: distance,
                limitedBy: endIndex)
        } else {
            self.index(
                endIndex,
                offsetBy: distance,
                limitedBy: startIndex)
        }
        
        guard let index = offsetIndex else { return self }
        let firstPart = self[index ..< endIndex]
        let lastPart = self[startIndex ..< index]
        return Array(firstPart + lastPart)
    }
}
