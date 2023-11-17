//
//  BeerOverviewListViewModel.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerOverviewListViewModel: ObservableObject {
    
    @Published var beers = [Beer]()
    
    let beerService: BeerServiceProtocol
    let perPage = Constants.beerPerPage
    
    var page: Int = 1
    @Published var favoritedBeerId = Set<Int>()

    init(beerService: BeerServiceProtocol) {
        
        self.beerService = beerService
    }
    
    enum Action {
        case initialLoad
        case loadNextPage
        case favoriteBeer(Int)
        case defavoriteBeer(Int)
    }
    
    func handleAction(_ action: Action) async {
        
        switch action {
        case .initialLoad:
            do {
                let newBeers = try await beerService.getBeersBy(page: page, perPage: perPage)
                DispatchQueue.main.async {
                    self.beers = newBeers
                }
            } catch {
                print(error)
            }
        case .loadNextPage:
            page += 1
            do {
                let newBeers = try await beerService.getBeersBy(page: page, perPage: perPage)
                DispatchQueue.main.async {
                    self.beers.append(contentsOf: newBeers)
                }
            } catch {
                print(error)
            }
        case let .favoriteBeer(id):
            favoritedBeerId.insert(id)
        case let .defavoriteBeer(id):
            favoritedBeerId.remove(id)
        }
    }
    
}
