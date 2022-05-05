//
//  Charecter.swift
//  rickandmorty-test
//
//  Created by molexey on 05.05.2022.
//

import Foundation

struct CharactersResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int    //1
    let name: String // Rick Sanchez
    let status: String   // Alive
    let species: String  //Human
    let type: String?   //
    let gender: String  //Male
    let origin: Origin
    let location: Location
    let image: String //https://rickandmortyapi.com/api/character/avatar/1.jpeg
    let episode: [String]?
    let url: String //https://rickandmortyapi.com/api/character/1
}

struct Origin: Decodable {
    let name: String  // Earth (C-137)
    let url: String?    // https://rickandmortyapi.com/api/location/1
}

struct Location: Decodable {
    let name: String   //Citadel of Ricks
    let url: String    //https://rickandmortyapi.com/api/location/3
}
