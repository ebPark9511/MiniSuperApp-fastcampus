//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
