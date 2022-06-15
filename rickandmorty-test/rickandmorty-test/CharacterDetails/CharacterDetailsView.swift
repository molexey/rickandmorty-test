//
//  CharacterDetailsView.swift
//  rickandmorty-test
//
//  Created by molexey on 19.05.2022.
//

import UIKit
import Combine

class CharacterDetailsView: UIView {
    
    private var cancellables: Set<AnyCancellable> = []
        
    let avatarImageView = UIImageView()
    let avatarImageSize : CGFloat = 200
    
    let nameLabel = UILabel()
    
    let statusIndicatorView = UIView()
    let statusAndSpeciesLabel = UILabel()
    
    let stackView = UIStackView()
    
    let locationView = DoubleLabelView(titleText: "Last known location:")
    let genderView = DoubleLabelView(titleText: "Gender:")
    let episodesView = DoubleLabelView(titleText: "Number of episodes:")
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemeted")
    }
}

extension CharacterDetailsView {
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 8
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 0
        
        statusIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        statusIndicatorView.backgroundColor = .systemGray
        statusIndicatorView.layer.cornerRadius = 5
        
        statusAndSpeciesLabel.translatesAutoresizingMaskIntoConstraints = false
        statusAndSpeciesLabel.text = "Status - Species"
        
        locationView.configure(with: " ")
        locationView.translatesAutoresizingMaskIntoConstraints = false
//        locationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        genderView.configure(with: " ")
        locationView.translatesAutoresizingMaskIntoConstraints = false
        
        episodesView.configure(with: " ")
        locationView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        
        locationView.translatesAutoresizingMaskIntoConstraints = false
        genderView.translatesAutoresizingMaskIntoConstraints = false
        episodesView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(statusAndSpeciesLabel)
        addSubview(statusIndicatorView)
        
        stackView.addArrangedSubview(locationView)
        stackView.addArrangedSubview(genderView)
        stackView.addArrangedSubview(episodesView)
        
        stackView.spacing = 16
                
        addSubview(stackView)
        
        avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageSize).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageSize).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 36).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 2).isActive = true
        
        statusAndSpeciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 2).isActive = true
        statusAndSpeciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        
        statusIndicatorView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        statusIndicatorView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        statusIndicatorView.centerYAnchor.constraint(equalTo: statusAndSpeciesLabel.centerYAnchor).isActive = true
        statusAndSpeciesLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: statusIndicatorView.trailingAnchor, multiplier: 1).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: statusAndSpeciesLabel.bottomAnchor, multiplier: 3).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}

extension CharacterDetailsView {
    func configure(with viewModel: CharacterDetailsViewModel.CharacterDetail) {
        guard let characterImageURL = viewModel.characterImageURL else { return }
        self.avatarImageView.loadImage(at: characterImageURL)
        
        guard let characterImage = viewModel.characterName else { return }
        self.nameLabel.text = characterImage
        
        guard let characterStatus = viewModel.characterStatus else { return }
        var characterStatusIndicatorColor: UIColor {
            switch characterStatus {
            case .alive:
                return .systemGreen
            case .dead:
                return .systemRed
            case .unknown:
                return .systemGray
            }
        }
        self.statusIndicatorView.backgroundColor = characterStatusIndicatorColor
        
        let statusAndSpecies = viewModel.statusAndSpecies
        self.statusAndSpeciesLabel.text = statusAndSpecies
        
        guard let characterLocation = viewModel.characterLocation else { return }
        self.locationView.configure(with: characterLocation)
        
        guard let characterGender = viewModel.characterGender else { return }
        self.genderView.configure(with: characterGender)
        
        guard let characterEpisodes = viewModel.characterEpisodes else { return }
        self.episodesView.configure(with: characterEpisodes)
    }
}
