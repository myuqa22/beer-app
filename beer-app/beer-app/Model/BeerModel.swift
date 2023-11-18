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
    let firstBrewed: String
    let description: String
    let imageUrl: String
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case description
        case imageUrl = "image_url"
        case ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
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
