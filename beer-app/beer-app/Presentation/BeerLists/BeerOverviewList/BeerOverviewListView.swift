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
                Text("Overview about different type of beers. \nTo favorite you can swipe an beer to the left.")
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
                            .task {
                                await viewModel.handleAction(.loadNextPage)
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .navigationTitle("Beer")
            }
            .padding(.horizontal, Constants.paddingSmall)
            .navigationDestination(for: Router.Path.self) { $0 }
        }
        .onAppear {
            Task {
                await viewModel.handleAction(.initialLoad)
            }
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: Text(alert.text))
        }
    }
    
}

#Preview {
    BeerOverviewListView(viewModel: BeerOverviewListViewModel(beerService: BeerService()))
        .environmentObject(Router())
}
