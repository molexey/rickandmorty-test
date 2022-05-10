//
//  Charecter.swift
//  rickandmorty-test
//
//  Created by molexey on 05.05.2022.
//

import Foundation
import ObjectMapper

struct CharactersResponse: Mappable {
    var info: Info?
    var results: [Character]?
    
    init?(map: Map) {
}
    
    mutating func mapping(map: Map) {
        info <- map["info"]
        results <- map["results"]
    }
}

struct Info: Mappable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        count <- map["count"]
        pages <- map["pages"]
        next <- map["next"]
        prev <- map["prev"]
    }
}

struct Character: Mappable {
    
    var id: Int?    //1
    var name: String? // Rick Sanchez
    var status: String?   // Alive
    var species: String?  //Human
    var type: String?   //
    var gender: String?  //Male
    var origin: Origin?
    var location: Location?
    var image: String? //https://rickandmortyapi.com/api/character/avatar/1.jpeg
    var episode: [String]?
    var url: String? //https://rickandmortyapi.com/api/character/1
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
        species <- map["species"]
        type <- map["type"]
        gender <- map["gender"]
        origin <- map["origin"]
        location <- map["location"]
        image <- map["image"]
        episode <- map["episode"]
        url <- map["url"]
        
    }
}

struct Origin: Mappable {
    
    var name: String?  // Earth (C-137)
    var url: String?    // https://rickandmortyapi.com/api/location/1
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
    }
}

struct Location: Mappable {

    var name: String?   //Citadel of Ricks
    var url: String?    //https://rickandmortyapi.com/api/location/3
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
    }
    
}
