//
//  CharactersTableViewDataSource.swift
//  rickandmorty-test
//
//  Created by molexey on 06.05.2022.
//

import UIKit
import CollectionAndTableViewCompatible

enum Sections: Int {
    case CharacterSection
}

class CharactersTableViewDataSource: TableViewDataSource {
    var data: [TableViewCompatible] {
        didSet {
            prepareData()
            tableView.reloadData()
        }
    }
    
    init(data: [TableViewCompatible] = [], tableView: UITableView) {
        self.data = data
        super.init(tableView: tableView)
    }
        
    func prepareData() {
        let section = TableViewSection(sortOrder: Sections.CharacterSection.rawValue, items: data, headerTitle: "Characters", footerTitle: nil)
        sections = [section].sorted {
            return $0.sortOrder < $1.sortOrder
        }
    }
    
}
