//
//  CharacterDetailsView.swift
//  rickandmorty-test
//
//  Created by molexey on 05.05.2022.
//

import UIKit

class CharacterDetailsView: UIView {
    
    let avatarImageView = UIImageView()
    let avatarImageSize : CGFloat = 200
    
    let nameLabel = UILabel()
    
    let statusIndictatorView = UIView()
    let statusAndSpeciesLabel = UILabel()
    
    let stackView = UIStackView()
    
    let locationTextLabel = UILabel()
    let locationLabel = UILabel()
    
    let genderTextLabel = UILabel()
    let genderLabel = UILabel()
    
    let episodesTextLabel = UILabel()
    let episodesLabel = UILabel()
    
    enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    struct ViewModel {
        let characterImageURL: String
        let characterName: String
        let characterStatus: Status
        let characterSpecies: String
        let characterLocation: String
        let characterGender: String
        
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
        
        var statusAndSpeciesLabel: String {
            return "\(characterStatus.rawValue) - \(characterSpecies)"
        }
        
        let charactersEpisodesCount: Int?
        
        var characterEpisodes: String {
            if let charactersEpisodesCount = charactersEpisodesCount {
                return String(charactersEpisodesCount)
            } else { return "--" }
        }
    }
    
    let viewModel: ViewModel? = nil
    
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
        nameLabel.text = "Rick Sanchez abc abc abc"
        //nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 0
        
        statusIndictatorView.translatesAutoresizingMaskIntoConstraints = false
        statusIndictatorView.backgroundColor = .systemGreen
        statusIndictatorView.layer.cornerRadius = 5
        
        statusAndSpeciesLabel.translatesAutoresizingMaskIntoConstraints = false
        statusAndSpeciesLabel.text = "Alive - Human"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        locationTextLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTextLabel.text = "Last known location:"
        locationTextLabel.textColor = .lightGray
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "Citadel of Ricks"
        
        genderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        genderTextLabel.text = "Gender:"
        genderTextLabel.textColor = .lightGray
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.text = "Male"
        
        episodesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        episodesTextLabel.text = "Number of episodes:"
        episodesTextLabel.textColor = .lightGray
        
        episodesLabel.translatesAutoresizingMaskIntoConstraints = false
        episodesLabel.text = "51"
    }
    
    func layout() {
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(statusAndSpeciesLabel)
        addSubview(statusIndictatorView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(locationTextLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(genderTextLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(episodesTextLabel)
        stackView.addArrangedSubview(episodesLabel)
        
        addSubview(stackView)
        
        avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageSize).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageSize).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 36).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 2).isActive = true
        
        statusAndSpeciesLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 2).isActive = true
        statusAndSpeciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        
        statusIndictatorView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        statusIndictatorView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        statusIndictatorView.centerYAnchor.constraint(equalTo: statusAndSpeciesLabel.centerYAnchor).isActive = true
        statusAndSpeciesLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: statusIndictatorView.trailingAnchor, multiplier: 1).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: statusAndSpeciesLabel.bottomAnchor, multiplier: 3).isActive = true
    }
}

extension CharacterDetailsView {
    func configure(with viewModel: ViewModel) {
        avatarImageView.loadImage(at: URL(string: viewModel.characterImageURL)!) // Force unwrapping!
        nameLabel.text = viewModel.characterName
        statusIndictatorView.backgroundColor = viewModel.characterStatusIndicatorColor
        statusAndSpeciesLabel.text = viewModel.statusAndSpeciesLabel
        
        locationLabel.text = viewModel.characterLocation
        genderLabel.text = viewModel.characterGender
        episodesLabel.text = viewModel.characterEpisodes
    }
}
