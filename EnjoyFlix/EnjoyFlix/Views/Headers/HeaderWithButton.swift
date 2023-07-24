//
//  HeaderWithButton.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 23.07.2023.
//

import UIKit

class HeaderWithButton: UICollectionReusableView {

    static let reuseIdentifier = "HeaderWithButton"
    

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .secondaryLabel

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

        ])
    }

    func set(withTitle title: String?) {
        titleLabel.text = title

    }
    
}
