//
//  CharacterCell.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    let avatarImage = UIImageView()
    let nameLabel = UILabel()
    let speciesLabel = UILabel()
    let genderLabel = UILabel()
    
    static let reuseID = "CharacterCell"
    static let rowHeight: CGFloat = 100
    
    struct ViewModel {
        let characterName: String
        let characterGender: String
        let characterSpecies: String
        let characterImageURL: String
    }
    
    let viewModel: ViewModel? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterCell {
    private func setup() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.backgroundColor = .gray
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.text = "Rick Sanchez"
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        speciesLabel.adjustsFontForContentSizeCategory = true
        speciesLabel.text = "Human"
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        genderLabel.adjustsFontForContentSizeCategory = true
        genderLabel.text = "Male"
        
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(genderLabel)
    }
    
    private func layout() {
//        let margins = self.layoutMarginsGuide
//
//        avatarImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
//        avatarImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        avatarImage.widthAnchor.constraint(equalToConstant: CharacterCell.rowHeight).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: CharacterCell.rowHeight).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImage.trailingAnchor, multiplier: 2).isActive = true
        nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2).isActive = true
        
        speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        speciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 2).isActive = true
        
        genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalToSystemSpacingBelow: speciesLabel.bottomAnchor, multiplier: 1).isActive = true
        
    }
}

extension CharacterCell {
    func configure(with viewModel: ViewModel) {
        //avatarImage = viewModel.characterImageURL
        nameLabel.text = viewModel.characterName
        speciesLabel.text = viewModel.characterSpecies
        genderLabel.text = viewModel.characterGender
    }
}
