//
//  BeerServer.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

protocol BeerServerProtocol {
    
    func execute(withPage: Int, withPerPage: Int) async throws -> [Beer]
}

class BeerServer: BeerServerProtocol {
    
    func execute(withPage: Int, withPerPage: Int) async throws -> [Beer] {
        
        let (data, _) = try await URLSession.shared.data(from: URL.beer(withPage: withPage, withPerPage: withPerPage))
        let decoded = try JSONDecoder().decode([Beer].self, from: data)
        
        return decoded
    }
    
}
