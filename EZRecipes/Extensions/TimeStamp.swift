//
//  TimeStamp.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 15/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import Foundation

extension Date {
    func timeStamp() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
