//
//  ListView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                VStack {
                    // creating items only as needed.
                    List {
                        ForEach(viewModel.beers) { beer in
                            CellView(name: beer.name, url: URL(string: beer.image_url)!)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        print("Starred")
                                    } label: {
                                        Text("⭐️")
                                    }
                                    .tint(.clear)
                                }
                                .onTapGesture {
                                    router.path.append(.detail(beer))
                                }
                        }
                        ProgressView()
                            .padding()
                            .task {
                                await viewModel.handleAction(.loadNextPage)
                            }
                    }
                   
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .navigationTitle("Beer")
                }
            }
            .onAppear {
                Task {
                    await viewModel.handleAction(.initialLoad)
                }
            }
            .navigationDestination(for: Router.Path.self) { path in
                AppPathView(path: path)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel(beerService: BeerService()))
    }
}
