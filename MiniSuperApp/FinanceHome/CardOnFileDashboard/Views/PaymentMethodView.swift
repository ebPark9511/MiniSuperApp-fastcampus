//
//  PaymentMethodView.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import UIKit

final class PaymentMethodView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.text = "nameLabel"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "subtitleLabel"
        return label
    }()
    
    init(viewModel: PaymentMethodViewModel) {
        super.init(frame: .zero)
        setupViews()
        
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.digits
        backgroundColor = viewModel.color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        
        backgroundColor = .blue
        
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            subtitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
        
    }
}
