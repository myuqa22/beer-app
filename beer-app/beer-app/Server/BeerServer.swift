//
//  BeerServer.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerServer: BeerServerProtocol {
   
    func fetchBeers(withPage: Int, withPerPage: Int) async throws -> [Beer] {
        
        let (data, _) = try await URLSession.shared.data(from: URL.beers(withPage: withPage, withPerPage: withPerPage))
        let decoded = try JSONDecoder().decode([Beer].self, from: data)
        
        return decoded
    }
    
    func fetchBeer(withId id: Int) async throws -> [Beer] {
        
        let (data, _) = try await URLSession.shared.data(from: URL.beer(withId: id))
        let decoded = try JSONDecoder().decode([Beer].self, from: data)
        
        return decoded
    }
    
}
