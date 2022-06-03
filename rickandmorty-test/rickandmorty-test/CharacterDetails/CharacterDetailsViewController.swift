//
//  CharacterDetailsViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var characterID: Int? = 0

    private let characterDetailsView = CharacterDetailsView()
    private let characterDetailsViewModel = CharacterDetailsViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        if let characterID = characterID {
            characterDetailsViewModel.getCharacter(with: (String(characterID)))
        }
        self.characterDetailsView.configure(with: self.characterDetailsViewModel)
    }
    
//    private func showErrorAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Try again",
//                                      style: .default,
//                                      handler: { [self] (action) in self.getCharacter(with: String(characterID!))
//        }))
//        present(alert, animated: true, completion:  nil)
//    }
}

extension CharacterDetailsViewController {
    private func setup() {
        characterDetailsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(characterDetailsView)
        
        NSLayoutConstraint.activate([
            characterDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: characterDetailsView.trailingAnchor, multiplier: 1),
            characterDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
