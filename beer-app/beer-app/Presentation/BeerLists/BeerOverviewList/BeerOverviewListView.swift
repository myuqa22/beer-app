//
//  BeerOverviewListView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI
import Defaults

struct BeerOverviewListView: View {
    
    @EnvironmentObject var router: Router
    
    @Default(.favoritedBeer) var favoritedBeer
    
    @ObservedObject var viewModel: BeerOverviewListViewModel
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                // creating items only as needed.
                List {
                    ForEach(viewModel.beers) { beer in
                        BeerCellView(beer: beer, favorite: favoritedBeer.contains(beer.id))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    Task {
                                        if favoritedBeer.contains(beer.id) {
                                            favoritedBeer.remove(beer.id)
                                        } else {
                                            favoritedBeer.insert(beer.id)
                                        }
                                    }
                                } label: {
                                    if favoritedBeer.contains(beer.id) {
                                        Text("❌")
                                    } else {
                                        Text("⭐️")
                                    }
                                    
                                }
                                .tint(.clear)
                            }
                            .onTapGesture {
                                router.path.append(.detail(beer))
                            }
                    }
                    if viewModel.beers.isEmpty {
                        Text("Could not load beer")
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    } else {
                        ProgressView()
                            .padding()
                            .task {
                                await viewModel.handleAction(.loadNextPage)
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .navigationTitle("Beer")
            }
            .navigationDestination(for: Router.Path.self) { path in
                AppPathView(path: path)
            }
        }
        .onAppear {
            Task {
                await viewModel.handleAction(.initialLoad)
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        BeerOverviewListView(viewModel: BeerOverviewListViewModel(beerService: BeerService()))
            .environmentObject(Router())
    }
}
