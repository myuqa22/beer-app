//
//  TestBeerOverviewListViewModel.swift
//  beer-app
//
//  Created by Privat on 19.11.23.
//

import XCTest
import Defaults
import Combine

@testable import beer_app

final class TestBeerOverviewListViewModel: XCTestCase {
    
    func testInitalLoad() async throws {
        
        let beerService = BeerService(beerServer: BeerMockServer())
        let viewModel = BeerOverviewListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
        
        XCTAssertEqual(viewModel.beers.count, .zero)
        
        let expectation = expectation(description: "receive beers")
        viewModel
            .$beers
            .dropFirst()
            .sink { beers in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await viewModel.handleAction(.initialLoad)
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewModel.beers.count, 10)
    }
    
    func testPagination() async throws {
        
        let beerService = BeerService(beerServer: BeerMockServer())
        let viewModel = BeerOverviewListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
        
        XCTAssertEqual(viewModel.beers.count, .zero)
        
        let expectation = expectation(description: "receive beers")
        viewModel
            .$beers
            .dropFirst()
            .sink { beers in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await viewModel.handleAction(.initialLoad)
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewModel.beers.count, 10)
        
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
        
        let expectation2 = self.expectation(description: "receive beers after pagination")
        viewModel
            .$beers
            .dropFirst()
            .sink { beers in
                expectation2.fulfill()
            }.store(in: &cancellables)
        
        await viewModel.handleAction(.loadNextPage)
        
        await fulfillment(of: [expectation2], timeout: 5)
        
        XCTAssertEqual(viewModel.page, 2)
        XCTAssertEqual(viewModel.beers.count, 20)
        
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
        
        let expectation3 = self.expectation(description: "receive beers after second pagination")
        viewModel
            .$beers
            .dropFirst()
            .sink { beers in
                expectation3.fulfill()
            }.store(in: &cancellables)
        
        await viewModel.handleAction(.loadNextPage)
        
        await fulfillment(of: [expectation3], timeout: 5)
        
        XCTAssertEqual(viewModel.page, 3)
        XCTAssertEqual(viewModel.beers.count, 30)
    }
    
    
    func testInitalLoadBeerError() async throws {
        
        let beerService = BeerService(beerServer: BeerFailedMockServer())
        let viewModel = BeerOverviewListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
        
        XCTAssertEqual(viewModel.beers.count, .zero)
        
        let expectation = expectation(description: "receive beers")
        viewModel
            .$alert
            .dropFirst()
            .sink { alert in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await viewModel.handleAction(.initialLoad)
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertNotNil(viewModel.alert)
    }
    
    func testInitalLoadBeerErrorAndPagination() async throws {
        
        let beerService = BeerService(beerServer: BeerFailedMockServer())
        let viewModel = BeerOverviewListViewModel(beerService: beerService)
        var cancellables = Set<AnyCancellable>()
        
        XCTAssertEqual(viewModel.beers.count, .zero)
        
        let expectation = expectation(description: "receive beers")
        viewModel
            .$alert
            .dropFirst()
            .sink { alert in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await viewModel.handleAction(.initialLoad)
        
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertNotNil(viewModel.alert)
    }
    
}
