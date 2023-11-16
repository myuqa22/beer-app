//
//  Beer+Mock.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

extension Beer {
    
    static var mock: Beer {
        
        Beer(id: 1, name: "Beer",
             tagline: "Tagline",
             first_brewed: "FirstBrewed",
             description: "Description",
             image_url: "https://picsum.photos/200/300",
             ingredients: Ingredients(
                malt: [
                    Ingredient(name: "Ingredient malt 1",
                               amount: Amount(value: 2, unit: "Liter"),
                               add: nil,
                               attribute: nil)
                ],
                hops: [
                    Ingredient(name: "Ingredient hops 1",
                               amount: Amount(value: 2, unit: "Liter"),
                               add: nil,
                               attribute: nil)
                ],
                yeast: "Yeast"),
             food_pairing: ["Chips"],
             brewers_tips: "No Tips",
             contributed_by: "Gerwin Lukman")
    }
    
}
