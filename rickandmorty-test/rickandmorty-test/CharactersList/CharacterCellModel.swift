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
    
    let characterID: Int
    let avatarImage: String
    let name: String
    let species: String
    let gender: String
    
    var selected: Bool = false
    var editable: Bool = false
    var movable: Bool = false
    
    init(characterID: Int, avatarImage: String, name: String, species: String, gender: String) {
        self.characterID = characterID
        self.avatarImage = avatarImage
        self.name = name
        self.species = species
        self.gender = gender
    }
    
    convenience init(character: Character) {
        self.init(characterID: character.id ?? -1, avatarImage: character.image ?? "", name: character.name ?? "", species: character.species ?? "", gender: character.gender ?? "")
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CharacterCell
        cell.configure(withModel: self)
        return cell
    }
    
}
