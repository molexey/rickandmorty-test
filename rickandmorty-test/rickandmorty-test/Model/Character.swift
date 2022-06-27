//
//  Charecter.swift
//  rickandmorty-test
//
//  Created by molexey on 05.05.2022.
//

import Foundation
import ObjectMapper
import RealmSwift

class ListTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = [AnyObject]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> Object? {
        let results = List<T>()
        if let objects = mapper.mapArray(JSONObject: value) {
            for object in objects {
                results.append(object)
            }
        }
        return results
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
}

class CharactersResponse: Object, Mappable, ObjectKeyIdentifiable {
    @Persisted var info: Info?
    @Persisted var results: List<Character>
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
}
    
    func mapping(map: ObjectMapper.Map) {
        info <- map["info"]
        results <- (map["results"], ListTransform<Character>())
    }
}

class Info: Object, Mappable {
    @Persisted var count: Int
    @Persisted var pages: Int
    @Persisted var next: String
    @Persisted var prev: String
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        count <- map["count"]
        pages <- map["pages"]
        next <- map["next"]
        prev <- map["prev"]
    }
}

class Character: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: Int?    //1
    @Persisted var name: String // Rick Sanchez
    @Persisted var status: String   // Alive
    @Persisted var species: String  //Human
    @Persisted var type: String  //
    @Persisted var gender: String  //Male
    @Persisted var origin: Origin?
    @Persisted var location: Location?
    @Persisted var image: String //https://rickandmortyapi.com/api/character/avatar/1.jpeg
    @Persisted var episode: List<String>
    @Persisted var url: String //https://rickandmortyapi.com/api/character/1
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
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

class Origin: Object, Mappable {
    
    @Persisted var name: String  // Earth (C-137)
    @Persisted var url: String    // https://rickandmortyapi.com/api/location/1
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
        url <- map["url"]
    }
}

class Location: Object, Mappable {

    @Persisted var name: String   //Citadel of Ricks
    @Persisted var url: String    //https://rickandmortyapi.com/api/location/3
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
        url <- map["url"]
    }
    
}
