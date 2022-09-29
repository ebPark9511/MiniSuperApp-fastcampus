//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import Foundation

protocol CardOnFileResitory {
    
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }

}

final class CardOnFileRepositoryImp: CardOnFileResitory {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodSubject }
    
    private let paymentMethodSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "신한카드", digits: "0987", color: "#3478f6ff", isPrimary: false),
//        PaymentMethod(id: "2", name: "현대카드", digits: "8121", color: "#78c5f5ff", isPrimary: false),
//        PaymentMethod(id: "3", name: "국민은행", digits: "2821", color: "#65c466ff", isPrimary: false),
//        PaymentMethod(id: "4", name: "카카오뱅크", digits: "8751", color: "#ffcc00ff", isPrimary: false),
    ])
    
}