//
//  Array.swift
//  AppWithTabs
//
//  Created by exey on 10.06.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import Foundation

extension RandomAccessCollection where Self.Element: Identifiable {
    
    func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
    
    
}
