//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import ModernRIBs
import UIKit

protocol AddPaymentMethodPresentableListener: AnyObject {
    func diddidTapClose()
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {

    weak var listener: AddPaymentMethodPresentableListener?
    
    private let cardNumberTextFild: UITextField = {
        let textField = makeTextField()
        textField.placeholder = "카드번호"
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        return stackView
    }()
    
    
    private var securityTextField: UITextField = {
        let textField = AddPaymentMethodViewController.makeTextField()
        textField.placeholder = "카드번호"
        return textField
    }()
    
    private var expirationTextField: UITextField = {
        let textField = AddPaymentMethodViewController.makeTextField()
        textField.placeholder = "유효기간"
        return textField
    }()
    
    private let addCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners()
        button.backgroundColor = .primaryRed
        button.setTitle("추가하기", for: .normal)
        button.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
        
        return button
    }()
    
    private static func makeTextField() -> UITextField {
        let textField = UITextField()
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.backgroundColor = .white
         textField.borderStyle = .roundedRect
         textField.keyboardType = .numberPad
         return textField
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        title = "카드 추가"
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            ),
            style: .plain,
            target: self,
            action: #selector(didTapClose)
        )
        
        view.addSubview(cardNumberTextFild)
        view.addSubview(stackView)
        view.addSubview(addCardButton)
        
        stackView.addArrangedSubview(securityTextField)
        stackView.addArrangedSubview(expirationTextField)
        
        NSLayoutConstraint.activate([
            cardNumberTextFild.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            cardNumberTextFild.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cardNumberTextFild.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        
            cardNumberTextFild.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            stackView.bottomAnchor.constraint(equalTo: addCardButton.topAnchor, constant: -20),
            addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
        
    }
    
    @objc
    private func didTapAddCard() {
        
    }

    @objc
    private func didTapClose() {
        // 닫는 행위는 라우팅 범위기 때문에
        listener?.diddidTapClose()
    }

}
