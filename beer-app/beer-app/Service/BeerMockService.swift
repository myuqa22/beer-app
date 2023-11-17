//
//  BeerMockService.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerMockService: BeerServiceProtocol {
    
    var beerServer: BeerServerProtocol = BeerMockServer()
    
    func getBeersBy(page: Int, perPage: Int) async throws -> [Beer] {
        
        try await beerServer.fetchBeers(withPage: page, withPerPage: perPage)
    }
    
    func getBeerBy(id: Int) async throws -> Beer? {
        
        try await beerServer.fetchBeer(withId: id)
    }
}
