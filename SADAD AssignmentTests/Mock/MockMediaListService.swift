//
//  MockMediaListService.swift
//  SADAD AssignmentTests
//
//  Created by Amin on 11/4/23.
//

import Foundation
import Combine
@testable import SADAD_Assignment

class MockMediaListService: MediaListServiceProtocol {
    
    
    private var mockLaunchesResponse : Result<[MediaModel], Error> = .failure(MockError.valueNotSet)
    
    func updateMock(with data: Result<[MediaModel], Error>) {
        mockLaunchesResponse = data
    }
    
    func fetchMediaList() -> AnyPublisher<[MediaModel], Error> {
        mockLaunchesResponse
            .publisher
            .delay(for: .milliseconds(100), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


enum MockError: Error {
    case valueNotSet
}
