//
//  CharacterCell.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let speciesLabel = UILabel()
    let genderLabel = UILabel()
    
    static let reuseID = "CharacterCell"
    static let rowHeight: CGFloat = 100
    
    var model: CharacterCellModel?
    
    private var observation: NSKeyValueObservation?
    
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
        //self.avatarImageView = model.character.image
        self.nameLabel.text = model.character.name
        self.speciesLabel.text = model.character.species
        self.genderLabel.text = model.character.gender

        // Remove previous observation
//        self.observation = nil
//
//        self.observation = model.observe(\.selected) { [unowned self] (model, change) in
//            self.updateCheckmark()
//        }

    }
    
}

extension CharacterCell {
    private func setup() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .systemGray5
        
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
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(genderLabel)
    }
    
    private func layout() {
//        let margins = self.layoutMarginsGuide
//
//        avatarImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
//        avatarImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        avatarImageView.widthAnchor.constraint(equalToConstant: CharacterCell.rowHeight).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: CharacterCell.rowHeight).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImageView.trailingAnchor, multiplier: 2).isActive = true
        nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2).isActive = true
        
        speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        speciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 2).isActive = true
        
        genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalToSystemSpacingBelow: speciesLabel.bottomAnchor, multiplier: 1).isActive = true
        
    }
    
}
