//
//  Router.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

class Router: ObservableObject {
    
    enum Path: Hashable {
        
        case detail(Beer)
    }
    
    @Published var path: [Path] = []
}

struct AppPathView: View {
    
    let path: Router.Path
    
    var body: some View {
        switch path {
        case .detail(let beer):
            DetailView(beer: beer)
        }
    }
    
}
