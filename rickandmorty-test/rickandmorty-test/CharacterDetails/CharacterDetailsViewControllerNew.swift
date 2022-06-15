//
//  CharacterDetailsViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit
import Combine

class CharacterDetailsViewControllerNew: UIViewController {
    
    var characterID: Int? = 0

    private let characterDetailsView = CharacterDetailsViewNew()
    private let viewModel = CharacterDetailsViewModelNew() //(characterID: "1")
    private var cancellable: AnyCancellable?
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()

        if let characterID = characterID {
        viewModel.send(event: .onAppear(characterID))
        }
        cancellable = viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: CharacterDetailsViewModelNew.State) {
        switch viewModel.state {
        case .idle:
            idle()
        case .loading:
            showActivityIndicator()
        case .loaded(let characterDetail):
            characterDetailsView.configure(with: characterDetail)
            UIView.animate(withDuration: 0.2, animations: {
                self.characterDetailsView.alpha = 1.0
            })
        case .error(let error):
            showErrorAlert(title: "Boom!", message: error.localizedDescription)
        }
    }
    
    private func idle() {
        
    }
    
    private func showActivityIndicator() {
        
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try again",
                                      style: .default,
                                      handler: { [self] (action) in
            guard let characterID = characterID else { return }
            viewModel.send(event: .onReload(characterID))
        }))
        present(alert, animated: true, completion:  nil)
    }
}

extension CharacterDetailsViewControllerNew {
    private func setup() {
        characterDetailsView.translatesAutoresizingMaskIntoConstraints = false
        characterDetailsView.alpha = 0.2
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
