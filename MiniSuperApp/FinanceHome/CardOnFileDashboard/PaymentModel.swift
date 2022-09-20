//
//  PaymentModel.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
