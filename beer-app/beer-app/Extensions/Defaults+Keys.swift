//
//  Defaults+Keys.swift
//  beer-app
//
//  Created by Privat on 18.11.23.
//

import Defaults

extension Defaults.Keys {
    
    static let favoritedBeer = Key<Set<Int>>("favoritedBeer", default: Set())
}
