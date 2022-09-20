//
//  AddPayMethodButton.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import UIKit

final class AddPayMethodButton: UIControl {
    
    private let plusIcon: UIImageView = {
       
        let imageView = UIImageView(
            image:UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
            )
        )
           
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }

    private func setupViews() {
        
        addSubview(plusIcon)
        
        NSLayoutConstraint.activate([
            plusIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
}

