//
//  ViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharactersViewController: UIViewController {

    // Request Models
    var characters: [Character] = []
    var currentInfо: Info? = nil
    
    var page = 1
    
    // View Models
    var characterCellViewModels: [CharacterCell.ViewModel] = []
    
    var tableView = UITableView()
    
    let apiCaller = APICaller.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        setup()
        
        //fetchCharacters()
        getCharacters(with: String(page))
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
    
    private func loadMoreCharacters() {
        let hasNextPage = (currentInfо?.next != nil)
        //activityIndicator.isHidden = true
        guard hasNextPage, !self.apiCaller.isLoading else { return }
        page += 1
        getCharacters(with: String(page))
        //activityIndicator.isHidden = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stoppedScrolling(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling(scrollView)
    }

    private func stoppedScrolling(_ scrollView: UIScrollView) {
        let offset: CGFloat = 100
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - offset {
            //activityIndicator.isHidden = false
            loadMoreCharacters()
        }
    }
    
    private func getCharacters(with param: String) {
        APICaller.shared.getCharacters(load: true, query: param) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.currentInfо = response.info
                    self.characters.append(contentsOf: response.results)
                case .failure(let error):
                    print(error)
                    self.showErrorAlert(title: "Boom!", message: error.localizedDescription)
                }
                self.configureTableCells(with: self.characters)
                self.tableView.reloadData()
            }
        }
    }
        
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try again",
                                      style: .default,
                                      handler: { [self] (action) in self.getCharacters(with: String(page))
        }))
        present(alert, animated: true, completion:  nil)
    }
    
    private func configureTableCells(with characters: [Character]) {
        characterCellViewModels = characters.map {
            CharacterCell.ViewModel(characterName: $0.name,
                                             characterGender: $0.gender,
                                             characterSpecies: $0.species,
                                             characterImageURL: $0.image)
        }
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
        let character: Character = characters[indexPath.row]
        viewController.characterID = character.id
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
