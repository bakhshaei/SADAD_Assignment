//
//  MediaListViewModelTests.swift
//  SADAD AssignmentTests
//
//  Created by Amin on 11/4/23.
//

import XCTest
@testable import SADAD_Assignment

final class MediaListViewModelTests: XCTestCase {

    //MARK: - Variables
    
    private var mockService : MockMediaListService!
    private var viewModel : MediaListViewModel!
    
    //MARK: - setup and teardown
    override func setUpWithError() throws {
        mockService = MockMediaListService()
        viewModel = MediaListViewModel(mediaService: mockService)
    }

    override func tearDownWithError() throws {
        //
    }
    
    //MARK: - Tests

    func test_CallFetchListFromService_ValuesUpdatesInViewModel() {
        // Setting mock date to mockService
        let mockModel : Array<MediaModel> = [.sampleImage, .sampleVideo]
        mockService.updateMock(with: .success(mockModel))
        
        // Calling ViewModel to fetch data from service
        viewModel.fetchList()
        
        // Defining expectation to get equal list from service
        let predicate = NSPredicate { viewModel, _ in
            switch (viewModel as? MediaListViewModel)?.mediaList {
            case .success(let list):
                XCTAssertEqual(mockModel, list)
                return list.count > 0
            case .failure(_), .none:
                return false
            }
        }
        
        let predExpect = XCTNSPredicateExpectation(predicate: predicate, object: viewModel)
        
        wait(for: [predExpect], timeout: 2.0)
        
    }

    func test_CallFetchList_ReceiveError_ListPresentFailureWithError() {
        // Setting desired error to mockService
        let mockError = URLError(.badServerResponse)
        mockService.updateMock(with: .failure(mockError))
        
        // Calling ViewModel to fetch from service
        viewModel.fetchList()
        
        
        //Defining expectation to get error
        let predicate = NSPredicate {viewModel, _ in
            switch (viewModel as? MediaListViewModel)?.mediaList {
            case .success(_), .none:
                return false
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
                return true
            }
        }
        
        let predExpect = XCTNSPredicateExpectation(predicate: predicate, object: viewModel)
        
        wait(for: [predExpect], timeout: 2.0)
    }
}
