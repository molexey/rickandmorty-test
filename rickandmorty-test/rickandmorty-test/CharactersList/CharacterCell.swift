//
//  CharacterCell.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit
import CollectionAndTableViewCompatible

class CharacterCell: UITableViewCell, Configurable {
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let speciesLabel = UILabel()
    let genderLabel = UILabel()
    
    static let reuseID = "CharacterCell"
    
    let avatarImageSize: CGFloat = 100
    
    var model: CharacterCellModel?
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        avatarImageView.cancelImageLoad()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withModel model: CharacterCellModel) {
        self.model = model
        self.avatarImageView.loadImage(at: URL(string: model.avatarImage)!)
        self.nameLabel.text = model.name
        self.speciesLabel.text = model.species
        self.genderLabel.text = model.gender
    }
    
}

extension CharacterCell {
    private func setup() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .systemGray5
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        //        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.numberOfLines = 0
        nameLabel.text = "Rick Sanchez"
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        speciesLabel.adjustsFontForContentSizeCategory = true
        speciesLabel.text = "Human"
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        genderLabel.adjustsFontForContentSizeCategory = true
        genderLabel.text = "Male"
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(genderLabel)
    }
    
    private func layout() {
        avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageSize).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageSize).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
//        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: avatarImageView.bottomAnchor, constant: 8).isActive = true
        avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImageView.trailingAnchor, multiplier: 2).isActive = true
        contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 2).isActive = true
        nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2).isActive = true
        
        speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        speciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 2).isActive = true
        
        genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalToSystemSpacingBelow: speciesLabel.bottomAnchor, multiplier: 1).isActive = true
//        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: genderLabel.bottomAnchor, constant: 8).isActive = true
//        contentView.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: genderLabel.bottomAnchor, multiplier: 1).isActive = true
        genderLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8).isActive = true


    }
    
    
}
