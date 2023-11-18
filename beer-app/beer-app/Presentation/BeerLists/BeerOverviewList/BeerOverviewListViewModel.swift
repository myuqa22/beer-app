//
//  BeerOverviewListViewModel.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import Foundation

class BeerOverviewListViewModel: ObservableObject {
    
    @Published var beers = [Beer]()
    @Published var alert: AlertMessage?
    
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
                let newBeers = try await beerService.getBeersBy(page: page, perPage: perPage)
                DispatchQueue.main.async {
                    self.beers = newBeers
                }
            } catch {
                alert = AlertMessage(text: "Failed loading beers")
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
                alert = AlertMessage(text: "Failed loading next page")
                print(error)
            }
        }
    }
    
}
