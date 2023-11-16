//
//  BeerModel.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

struct Beer: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let tagline: String
    let first_brewed: String
    let description: String
    let image_url: String
    let ingredients: Ingredients
    let food_pairing: [String]
    let brewers_tips: String
    let contributed_by: String
}

struct Ingredients: Codable, Hashable {
    
    let malt: [Ingredient]
    let hops: [Ingredient]
    let yeast: String
}

struct Ingredient: Codable, Hashable {
    
    let name: String
    let amount: Amount
    let add: String?
    let attribute: String?
}

struct Amount: Codable, Hashable {
    
    let value: Double
    let unit: String
}
