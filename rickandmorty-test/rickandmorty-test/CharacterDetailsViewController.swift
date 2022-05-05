//
//  CharacterDetailsViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    let characterDetailsView = CharacterDetailsView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()

        // Do any additional setup after loading the view.
    }
    
}

extension CharacterDetailsViewController {
    private func style() {
        characterDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        view.addSubview(characterDetailsView)
        
        NSLayoutConstraint.activate([
            characterDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: characterDetailsView.trailingAnchor, multiplier: 1),   characterDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//            characterDetailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            characterDetailsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: characterDetailsView.trailingAnchor, multiplier: 1)
            
        ])
    }
}
