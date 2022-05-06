//
//  CharacterCellModel.swift
//  rickandmorty-test
//
//  Created by molexey on 06.05.2022.
//
import UIKit
import CollectionAndTableViewCompatible

class CharacterCellModel: NSObject, TableViewCompatible {
    
    let reuseIdentifier: String = "CharacterCell"
    
    let character: Character
    
    @objc dynamic var selected: Bool = false
    
    var editable: Bool = false
    var movable: Bool = false
    
    init(character: Character) {
        self.character = character
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CharacterCell
        cell.configure(withModel: self)
        return cell
    }
    
}
