//
//  APICaller.swift
//  rickandmorty-test
//
//  Created by molexey on 05.05.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    var isLoading = false
    var urlComponents = URLComponents(string: "https://rickandmortyapi.com")
    
    private init() {}
    
    // MARK: - Public
    
    // Get all characters
    public func getCharacters(
        load: Bool = false,
        query: String,
        completion: @escaping (Result<CharactersResponse, Error>) -> Void
    ) {
        if load {
            isLoading = true
        }
        // URL https://rickandmortyapi.com/api/character?page=1
        urlComponents?.path = "/api/character"
        urlComponents?.queryItems = [ URLQueryItem(name: "page", value: query) ]
                
        guard let url = urlComponents?.url else { return }
        print(url)
        request(url: url, expecting: CharactersResponse.self, load: load, completion: completion)
    }
    
    // Get a character
    public func getCharacter(
        load: Bool = false,
        characterID: String,
        completion: @escaping (Result<Character, Error>) -> Void
    ) {
        // URL https://rickandmortyapi.com/api/character/2
        urlComponents = URLComponents(string: "https://rickandmortyapi.com")
        urlComponents?.path = "/api/character/\(characterID)"
        guard let url = urlComponents?.url else { return }
        print(url)
        request(url: url, expecting: Character.self, load: load, completion: completion)
    }
    
    
    // MARK: - Private
    
    private enum APIError: Error {
        case noDataReturned
        case invalidURL
    }
    
    private func request<T: Decodable>(
        url: URL?,
        expecting: T.Type,
        load: Bool,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
            print(APIError.invalidURL)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(expecting, from: data)
                
                completion(.success(result))
                if load {
                    self.isLoading = false
                }
                
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}