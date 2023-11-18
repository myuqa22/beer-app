//
//  TestBeerFavoriteViewModel.swift
//  beer-appTests
//
//  Created by Privat on 19.11.23.
//

import XCTest
import Defaults
import Combine

@testable import beer_app

final class TestBeerFavoriteViewModel: XCTestCase {

    override func setUp() {
        
        super.setUp()
        
        Defaults.removeAll()
    }
    
    override func tearDown() {
        
        super.tearDown()
        
        Defaults.removeAll()
    }
    
    func testLoadNoFavoriteBeers() async throws {
        
        let beerService = BeerService(beerServer: BeerMockServer())
        let viewModel = BeerFavoriteListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
        
        let expectation = expectation(description: "receive favorite beers")
        viewModel
            .$favorited
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        let favoriteBeers = Defaults[.favoritedBeer]
        
        XCTAssertEqual(favoriteBeers.count, .zero)
        
        await viewModel.handleAction(.loadFavoriteBeers(favoriteBeers))
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.favorited.count, .zero)
    }
    
    func testLoadFavoriteBeers() async throws {
        
        let beerService = BeerService(beerServer: BeerMockServer())
        let viewModel = BeerFavoriteListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
    
        let expectation = expectation(description: "load favorite beers")
        // 1. isLoading = true
        // 2. isLoading = false
        expectation.expectedFulfillmentCount = 2
        
        viewModel
            .$isLoading
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        Defaults[.favoritedBeer] = [1, 2, 3, 4]
        
        let favoriteBeers = Defaults[.favoritedBeer]
        
        XCTAssertEqual(favoriteBeers.count, 4)
        
        await viewModel.handleAction(.loadFavoriteBeers(favoriteBeers))
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.favorited.count, favoriteBeers.count)
    }
    
    func testLoadFavoriteBeersFailed() async throws {
        
        let beerService = BeerService(beerServer: BeerFailedMockServer())
        let viewModel = BeerFavoriteListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
    
        let expectation = expectation(description: "load favorite beers")
        // 1. isLoading = true
        // 2. isLoading = false
        expectation.expectedFulfillmentCount = 2
        
        viewModel
            .$isLoading
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        Defaults[.favoritedBeer] = [1, 2, 3, 4]
        
        let favoriteBeers = Defaults[.favoritedBeer]
        
        XCTAssertEqual(favoriteBeers.count, 4)
        
        await viewModel.handleAction(.loadFavoriteBeers(favoriteBeers))
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.favorited.count, .zero)
        XCTAssertNotNil(viewModel.alert)
    }

}
