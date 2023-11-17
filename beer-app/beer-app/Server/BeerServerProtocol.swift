//
//  BeerServerProtocol.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

protocol BeerServerProtocol {
    
    func fetchBeers(withPage: Int, withPerPage: Int) async throws -> [Beer]
    func fetchBeer(withId id: Int) async throws -> Beer?
}
