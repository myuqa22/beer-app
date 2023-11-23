//
//  Router.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

class Router: ObservableObject {
    
    enum Path: Hashable, View {
        case detail(Beer)
        
        var body: some View {
            switch self {
            case .detail(let beer):
                BeerDetailView(beer: beer)
            }
        }
    }
    
    @Published var path: [Path] = []
}
