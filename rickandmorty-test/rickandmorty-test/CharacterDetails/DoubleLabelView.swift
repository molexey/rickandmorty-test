//
//  TwoLabelView.swift
//  rickandmorty-test
//
//  Created by molexey on 19.05.2022.
//

import UIKit

class DoubleLabelView: UIView {
    
    let titleText: String
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    init(titleText: String) {
        self.titleText = titleText
        super.init(frame: .zero)
        titleLabel.text = self.titleText
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with subTitleText: String) {
//        titleLabel.text = self.titleText
        subTitleLabel.text = subTitleText
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}
