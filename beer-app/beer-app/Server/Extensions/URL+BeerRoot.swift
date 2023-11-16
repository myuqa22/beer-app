//
//  URL+BeerRoot.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

extension URL {
    
    static func beer(withPage page: Int, withPerPage perPage: Int) -> URL {
        
        URL(string: "https://api.punkapi.com/v2/beers?page=\(page)&per_page=\(perPage)")!
    }
    
}
