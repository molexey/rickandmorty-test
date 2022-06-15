//
//  CharacterDetailsViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit
import Combine

class CharacterDetailsViewController: UIViewController {
    
    private let characterDetailsView = CharacterDetailsView()
    private let viewModel: CharacterDetailsViewModel
    private var cancellable: AnyCancellable?
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()

        viewModel.send(event: .onAppear)
        cancellable = viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: CharacterDetailsViewModel.State) {
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
            viewModel.send(event: .onReload)
        }))
        present(alert, animated: true, completion:  nil)
    }
}

extension CharacterDetailsViewController {
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
