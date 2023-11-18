//
//  BeerFavoriteListView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI
import Defaults

struct BeerFavoriteListView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: BeerFavoriteListViewModel
    
    @Default(.favoritedBeer) var favoritedBeer
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                if favoritedBeer.isEmpty {
                    Text("To add an beer to the favorite area, please use swipe action.")
                        .font(.subheadline)
                }
                if viewModel.isLoading {
                    ProgressView()
                }
                List {
                    ForEach(viewModel.favorited, id: \.id) { beer in
                        BeerCellView(beer: beer)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
                .animation(.easeIn, value: viewModel.favorited)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .navigationTitle("Favorited")
            .navigationDestination(for: Router.Path.self) { path in
                AppPathView(path: path)
            }
        }
        .task {
            for await _ in Defaults.updates(.favoritedBeer) {
                await viewModel.handleAction(.loadFavoriteBeers)
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        BeerFavoriteListView(viewModel: BeerFavoriteListViewModel(beerService: BeerMockService()))
            .environmentObject(Router())
    }
}
