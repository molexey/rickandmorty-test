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
    private let viewModel = CharacterDetailsViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        if let characterID = characterID {
            viewModel.getCharacter(with: (String(characterID)))
        }
        
        viewModel.showAlertClosure = { [weak self] () in
            if let message = self?.viewModel.alertMessage {
                self?.showErrorAlert(title: "Boom!", message: message)
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            let isLoading = self?.viewModel.isLoading //?? false
            if !isLoading! {
                UIView.animate(withDuration: 0.2, animations: {
                    self?.characterDetailsView.alpha = 1.0
                })
            }
        }
        
        self.characterDetailsView.configure(with: self.viewModel)
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try again",
                                      style: .default,
                                      handler: { [self] (action) in viewModel.getCharacter(with: String(characterID!))
        }))
        present(alert, animated: true, completion:  nil)
    }
}

extension CharacterDetailsViewController {
    private func setup() {
        characterDetailsView.translatesAutoresizingMaskIntoConstraints = false
//        characterDetailsView.isHidden = true
        characterDetailsView.alpha = 0.3
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
