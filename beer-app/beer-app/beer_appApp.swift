//
//  beer_appApp.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

@main
struct beer_appApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            ListView(viewModel: ListViewModel(beerService: BeerService()))
                .environmentObject(Router())
        }
    }
    
}
