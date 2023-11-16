//
//  BeerService.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

protocol BeerServiceProtocol {

    func getBeerBy(page: Int, perPage: Int) async throws -> [Beer]
}

class BeerService: BeerServiceProtocol {
    
    var beerServer: BeerServer = BeerServer()
    
    func getBeerBy(page: Int, perPage: Int) async throws -> [Beer] {
        
        try await BeerServer().execute(withPage: page, withPerPage: perPage)
    }
}
