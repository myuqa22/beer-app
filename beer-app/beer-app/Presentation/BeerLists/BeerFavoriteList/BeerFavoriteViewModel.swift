//
//  BeerFavoriteViewModel.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

import Defaults

class BeerFavoriteListViewModel: ObservableObject {
    
    @Published var favorited = [Beer]()
    @Published var isLoading = false
    @Published var alert: AlertMessage?
    
    let beerService: BeerServiceProtocol
    
    init(beerService: BeerServiceProtocol) {
        
        self.beerService = beerService
    }
    
    enum Action {
        
        case loadFavoriteBeers(Set<Int>)
    }
    
    func handleAction(_ action: Action) async {
        
        switch action {
        case let .loadFavoriteBeers(favoritedBeer):
            DispatchQueue.main.async {
                self.isLoading = true
                self.favorited.removeAll()
            }
            do {
                for id in favoritedBeer.sorted() {
                    if let newBeers = try await beerService.getBeerBy(id: id) {
                        DispatchQueue.main.async {
                            self.favorited
                                .append(newBeers)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            } catch {
                self.isLoading = false
                alert = AlertMessage(text: "Failed loading favorite beers")
                print(error)
            }
        }
    }
    
}
