//
//  ViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharactersViewController: UIViewController {

    //var characters = []
    
    var characterCellViewModels: [CharacterCell.ViewModel] = []
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        setup()
        
        fetchCharacters()
    }
}

extension CharactersViewController {
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseID)
        tableView.rowHeight = CharacterCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !characterCellViewModels.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseID, for: indexPath) as! CharacterCell
        let character = characterCellViewModels[indexPath.row]
        
        cell.configure(with: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterCellViewModels.count
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = CharacterDetailsViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CharactersViewController {
    private func fetchCharacters() {
        let character1 = CharacterCell.ViewModel(characterName: "Rick Sanchez", characterGender: "Male", characterSpecies: "Human", characterImageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        
        let character2 = CharacterCell.ViewModel(characterName: "Morty Smith", characterGender: "Male", characterSpecies: "Human", characterImageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
        
        let character3 = CharacterCell.ViewModel(characterName: "Summer Smith", characterGender: "Female", characterSpecies: "Human", characterImageURL: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")
        
        characterCellViewModels.append(character1)
        characterCellViewModels.append(character2)
        characterCellViewModels.append(character3)
    }
}
