//
//  Extension.swift
//  ScanApp
//
//  Created by Macintosh HD on 5/31/18.
//  Copyright © 2018 google. All rights reserved.
//

import UIKit

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
