//
//  Extensions.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation

extension Date {
    var timeStamp: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
