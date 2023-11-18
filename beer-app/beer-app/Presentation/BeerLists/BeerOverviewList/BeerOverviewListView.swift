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
    
   
    
    @ObservedObject var viewModel: BeerOverviewListViewModel
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                Text("To favorite you can swipe an beer to the left.")
                List {
                    ForEach(viewModel.beers) { beer in
                        BeerCellView(beer: beer)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
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

#Preview {
    BeerOverviewListView(viewModel: BeerOverviewListViewModel(beerService: BeerService()))
        .environmentObject(Router())
}
