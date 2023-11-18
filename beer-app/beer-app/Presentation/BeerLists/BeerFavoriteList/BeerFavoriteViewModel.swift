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
                print(error)
            }
        }
    }
    
    func getFavoriteBeer(byId id: Int) async -> Beer? {
        do {
            return try await beerService.getBeerBy(id: id)
        } catch {
            print(error)
            return nil
        }
    }
    
}
