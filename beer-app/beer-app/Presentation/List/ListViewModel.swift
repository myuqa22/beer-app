//
//  ListViewModel.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var beers = [Beer]()
    
    let beerService: BeerServiceProtocol
    let perPage = Constants.beerPerPage
    
    var page: Int = 1
    
    
    init(beerService: BeerServiceProtocol) {
        
        self.beerService = beerService
    }
    
    enum Action {
        case initialLoad
        case loadNextPage
    }
    
    func handleAction(_ action: Action) async {
        
        switch action {
        case .initialLoad:
            do {
                self.beers = try await beerService.getBeerBy(page: page, perPage: perPage)
            } catch {
                print(error)
            }
        case .loadNextPage:
            page += 1
            do {
                let newBeers = try await beerService.getBeerBy(page: page, perPage: perPage)
                self.beers.append(contentsOf: newBeers)
            } catch {
                print(error)
            }
        }
    }
    
}
