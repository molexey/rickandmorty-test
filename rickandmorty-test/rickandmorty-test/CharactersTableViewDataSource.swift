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
    
    let characters: [Character]

    init(сharacters characters: [Character], tableView: UITableView) {
        self.characters = characters
        
        super.init(tableView: tableView)
    }
    
    func prepareData() {
                
        var items = [TableViewCompatible]()
                
        for character in self.characters {
            let characterCellModel = CharacterCellModel(character: character)
            //characterCellModel.selected =
            items.append(characterCellModel)
        }
        print("items: \(items)")
        let section = TableViewSection(sortOrder: Sections.CharacterSection.rawValue, items: items, headerTitle: "Characters", footerTitle: nil)

        sections = [section].sorted {
            return $0.sortOrder < $1.sortOrder
        }
    }
    
}
