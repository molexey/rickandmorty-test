//
//  ViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit
import Combine
import CollectionAndTableViewCompatible

class CharactersViewController: UIViewController {
    
    private let viewModel: CharactersListViewModel
    private var cancellable: AnyCancellable?
        
    var tableView = UITableView()
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        setup()
        
        viewModel.send(event: .onAppear)
        cancellable = viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.render(state)
            }
    }
    
    private func render(_ state: CharactersListViewModel.State) {
        switch viewModel.state {
        case .idle:
            idle()
        case .loading:
            showActivityIndicator()
        case .loaded:
            self.tableView.reloadData()
        case .error(let error):
            showErrorAlert(title: "Boom!", message: error.localizedDescription)
        }
    }
}

extension CharactersViewController {
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
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
            viewModel.send(event: .onLoadMore)
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

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character: Character = viewModel.characters[indexPath.row]
        let viewModel = CharacterDetailsViewModel(characterID: character.id!) //
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.data[indexPath.row]
        return cellModel.cellForTableView(tableView: tableView, atIndexPath: indexPath)
    }
}
