//
//  BeerFailedMockServer.swift
//  beer-app
//
//  Created by Privat on 19.11.23.
//

import Foundation

class BeerFailedMockServer: BeerServerProtocol {
    
    func fetchBeers(withPage: Int, withPerPage: Int) throws -> [Beer] {
        
        throw CustomError.error
    }
    
    func fetchBeer(withId id: Int) throws -> [Beer] {
        
        throw CustomError.error
    }

}
