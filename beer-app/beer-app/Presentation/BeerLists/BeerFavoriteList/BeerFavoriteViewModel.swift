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
    
    @Default(.favoritedBeer) var favoritedBeer
    
    let beerService: BeerServiceProtocol
    
    init(beerService: BeerServiceProtocol) {
        
        self.beerService = beerService
    }
    
    enum Action {
        case loadFavoriteBeers
    }
    
    func handleAction(_ action: Action) async {
        
        switch action {
        case .loadFavoriteBeers:
            isLoading = true
            var newBeer = [Beer]()
            do {
                for id in favoritedBeer {
                    if let newBeers = try await beerService.getBeerBy(id: id) {
                        DispatchQueue.main.async {
                            newBeer.append(newBeers)
                        }
                    }
                }
                DispatchQueue.main.async {
                    newBeer.sort { lhs, rhs in
                        lhs.name < rhs.name
                    }
                    self.isLoading = false
                    self.favorited = newBeer
                }
            } catch {
                alert = AlertMessage(text: "Failed loading favorite beers")
                print(error)
            }
        }
    }
    
}
