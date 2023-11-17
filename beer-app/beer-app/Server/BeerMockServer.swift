//
//  BeerMockServer.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerMockServer: BeerServerProtocol {
    
    func fetchBeers(withPage: Int, withPerPage: Int) async throws -> [Beer] {
        
        let path = Bundle.main.path(forResource: "MockData", ofType: "json")
        let mock = try! String(contentsOfFile: path!)
        
        do {
            let data = mock.data(using: .utf8)
            let beers = try JSONDecoder().decode([Beer].self, from: data!)
            return beers
            
        } catch let error {
            print(error)
            return []
        }
    }
    
    func fetchBeer(withId id: Int) async throws -> Beer? {
        
        let decoder = JSONDecoder()
        let path = Bundle.main.path(forResource: "SingleMockData", ofType: "json")
        let mock = try! String(contentsOfFile: path!)
        
        do {
            let data = mock.data(using: .utf8)
            let beer = try decoder.decode(Beer.self, from: data!)
            
            let modifiedBeer = Beer(id: id,
                                    name: beer.name + " MOCKED \(id)",
                                    tagline: beer.tagline,
                                    first_brewed: beer.first_brewed,
                                    description: beer.description,
                                    image_url: beer.image_url,
                                    ingredients: beer.ingredients,
                                    food_pairing: beer.food_pairing,
                                    brewers_tips: beer.brewers_tips,
                                    contributed_by: beer.contributed_by)
            return modifiedBeer
            
        } catch let error {
            print(error)
            return nil
        }
    }
    
}
