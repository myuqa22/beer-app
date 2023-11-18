//
//  BeerTabBarView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct BeerTabBarView: View {
    
    let beerService: BeerServiceProtocol
    
    var body: some View {
        
        TabView {
            BeerOverviewListView(viewModel: BeerOverviewListViewModel(beerService: beerService))
                .environmentObject(Router())
                .tabItem {
                    Label(title: {
                        Text("List")
                    }, icon: {
                        Image(systemName: "list.bullet")
                    })
                }
            BeerFavoriteListView(viewModel: BeerFavoriteListViewModel(beerService: beerService))
                .environmentObject(Router())
                .tabItem {
                    Label(title: {
                        Text("Favorite")
                    }, icon: {
                        Image(systemName: "star")
                    })
                }
        }
    }
    
}

#Preview {
    BeerTabBarView(beerService: BeerService(beerServer: BeerMockServer()))
}
