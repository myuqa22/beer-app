//
//  BeerMockServer.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerMockServer: BeerServerProtocol {
    
    func fetchBeers(withPage: Int, withPerPage: Int) throws -> [Beer] {
        
        let path = Bundle.main.path(forResource: "MockData", ofType: "json")
        let mock = try! String(contentsOfFile: path!)
        
        let data = mock.data(using: .utf8)
        let beers = try JSONDecoder().decode([Beer].self, from: data!)
        return beers
        
    }
    
    func fetchBeer(withId id: Int) throws -> [Beer] {
        
        let decoder = JSONDecoder()
        let path = Bundle.main.path(forResource: "SingleMockData", ofType: "json")
        let mock = try! String(contentsOfFile: path!)
        
        
        let data = mock.data(using: .utf8)
        let beer = try decoder.decode([Beer].self, from: data!).first!
        
        let modifiedBeer = Beer(id: id,
                                name: beer.name + " MOCKED \(id)",
                                tagline: beer.tagline,
                                firstBrewed: beer.firstBrewed,
                                description: beer.description,
                                imageUrl: beer.imageUrl,
                                ingredients: beer.ingredients,
                                foodPairing: beer.foodPairing,
                                brewersTips: beer.brewersTips,
                                contributedBy: beer.contributedBy)
        return [modifiedBeer]
        
        
    }
    
}
