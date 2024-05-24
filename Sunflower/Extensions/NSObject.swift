//
//  NSObject.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
