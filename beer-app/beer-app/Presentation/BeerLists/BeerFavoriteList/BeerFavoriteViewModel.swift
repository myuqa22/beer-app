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
    
    @Default(.favoritedBeer) var favoritedBeer
    
    let beerService: BeerServiceProtocol
    
    init(beerService: BeerServiceProtocol) {
        
        self.beerService = beerService
    }
    
    enum Action {
        case initialLoad
    }
    
    func handleAction(_ action: Action) async {
        
        switch action {
        case .initialLoad:
            self.favorited.removeAll()
            do {
                for id in favoritedBeer {
                    if let newBeers = try await beerService.getBeerBy(id: id) {
                        DispatchQueue.main.async {
                            self.favorited.append(newBeers)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.favorited.sort { lhs, rhs in
                        lhs.name < rhs.name
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
}
