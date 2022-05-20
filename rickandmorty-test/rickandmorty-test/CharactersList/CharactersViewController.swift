//
//  ViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharactersViewController: UIViewController {

    var characters: [Character] = []
    var currentInfо: Info? = nil
    var page = 1
        
    var tableView = UITableView()
    var dataSource: CharactersTableViewDataSource!
    
    let apiCaller = APICaller.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        setup()
//        fetchCharacters()
        getCharacters(with: String(page))
    }
}

extension CharactersViewController {
    
    private func setup() {
        dataSource = CharactersTableViewDataSource(data: [], tableView: tableView)
        tableView.delegate = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
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
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    self.currentInfо = response.info
                    if let characters = response.results {
                    self.characters.append(contentsOf: characters)
                        self.dataSource.data.append(contentsOf: self.characters.map({CharacterCellModel(character: $0)}))
                    }
                case .failure(let error):
                    print(error)
                    self.showErrorAlert(title: "Boom!", message: error.localizedDescription)
                }
                self.dataSource.data = self.characters.map({CharacterCellModel(character: $0)})
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
        let character1 = CharacterCellModel(avatarImage: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", name: "Rick Sanchez" , species: "Human", gender: "Male")

        let character2 = CharacterCellModel(avatarImage: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", name: "Morty Superlongnastname Name Name" , species: "Human", gender: "Male")
        
        let character3 = CharacterCellModel(avatarImage: "https://rickandmortyapi.com/api/character/avatar/3.jpeg", name: "Summer Smith" , species: "Human", gender: "Female")

        var mockCharacters = [CharacterCellModel]()
        mockCharacters.append(character1)
        mockCharacters.append(character2)
        mockCharacters.append(character3)
        
        self.dataSource.data = mockCharacters
    }
}
