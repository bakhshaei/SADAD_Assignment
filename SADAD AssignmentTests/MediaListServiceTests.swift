//
//  MediaListServiceTests.swift
//  SADAD AssignmentTests
//
//  Created by Amin on 11/3/23.
//

import XCTest
import Combine
@testable import SADAD_Assignment

final class MediaListServiceTests: XCTestCase {
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_FetchMediaList_HappyScenario_FetchAtLeastOneItem() {
        let service = MediaListService()
        
        // Create an XCTestExpectation to wait for data to be received
        let expectReceive = XCTestExpectation(description: "Receive list.")
        
        // Fetch the media list and handle the publisher's output
        service.fetchMediaList()
            .sink { completion in
                switch completion {
                case .finished:
                    // The publisher has successfully finished
                    break
                    
                case .failure(let error):
                    // An error occurred during the fetch, fail the test
                    XCTFail("Failed to receive, error: \(error)")
                }
            } receiveValue: { list in
                // Handle the received list of media items
                if list.count > 0 {
                    // If at least one item was received, fulfill the expectation
                    expectReceive.fulfill()
                }
            }
            .store(in: &cancellableSet)
        
        // Wait for the expectation to be fulfilled (max 2 seconds timeout)
        wait(for: [expectReceive], timeout: 2.0)
    }
    

}
