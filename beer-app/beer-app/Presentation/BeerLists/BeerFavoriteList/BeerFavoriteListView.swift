//
//  BeerFavoriteListView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct BeerFavoriteListView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: BeerFavoriteListViewModel
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                List {
                    ForEach(viewModel.favorited) { beer in
                        BeerCellView(beer: beer, favorite: true)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                router.path.append(.detail(beer))
                            }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .navigationTitle("Favorited")
            .task {
                await viewModel.handleAction(.initialLoad)
            }
            .navigationDestination(for: Router.Path.self) { path in
                AppPathView(path: path)
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
