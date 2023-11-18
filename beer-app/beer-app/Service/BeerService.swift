//
//  BeerService.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerService: BeerServiceProtocol {
    
    var beerServer: BeerServerProtocol
    
    init(beerServer: BeerServerProtocol = BeerServer()) {
        
        self.beerServer = beerServer
    }
    
    func getBeersBy(page: Int, perPage: Int) async throws -> [Beer] {
        
        try await beerServer.fetchBeers(withPage: page, withPerPage: perPage)
    }
    
    func getBeerBy(id: Int) async throws -> Beer? {
        
        try await beerServer.fetchBeer(withId: id).first
    }
}
