//
//  BeerServiceProtocol.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

protocol BeerServiceProtocol {
    
    var beerServer: BeerServerProtocol { get set }

    func getBeersBy(page: Int, perPage: Int) async throws -> [Beer]
    func getBeerBy(id: Int) async throws -> Beer?
}
