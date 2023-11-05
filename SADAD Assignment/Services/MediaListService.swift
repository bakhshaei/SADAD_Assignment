//
//  MediaListService.swift
//  SADAD Assignment
//
//  Created by Amin on 11/3/23.
//

import Foundation
import Combine

protocol MediaListServiceProtocol {
    
    /// Fetch a list of media items from a remote API
    /// - Returns: A Publisher contains a list of `MediaModel` if sucess, otherwise publishes and error.
    func fetchMediaList() -> AnyPublisher<[MediaModel], Error>
}



class MediaListService: MediaListServiceProtocol {
    
    /// BaseURL is the address of API with it's endpoint.
    private let baseURL = URL(string: "https://c62881db-c803-4c5e-907e-3b1d843fa7fd.mock.pstmn.io/medialist")
    
    /// Fetch a list of media items from a remote API
    /// - Returns: A Publisher contains a list of `MediaModel` if sucess, otherwise publishes and error.
    func fetchMediaList() -> AnyPublisher<[MediaModel], Error> {
        
        // Ensure the base URL is valid
        guard let url = baseURL else {
            // Return a publisher with a failure if the URL is invalid
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Use URLSession to fetch data from the specified URL
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                assert(!Thread.isMainThread)
                
                // Extracing statusCode from received Response
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw ServiceError.unexpectedResponse
                }
                
                // Make sure that the statusCode is in SuccessRange(200-299), otherwide return and error
                guard (200..<300).contains(code) else {
                    throw ServiceError.httpCode(code)
                }
                return $0.0
            }
            .decode(type: [MediaModel].self, decoder: JSONDecoder()) // Decode JSON data into an array of MediaModel
            .receive(on: DispatchQueue.main) // Ensure UI updates are on the main thread
            .eraseToAnyPublisher() // Erase the specific publisher type for abstraction
    }
    
    
    enum ServiceError: Error {
        case unexpectedResponse
        case httpCode(Int)
    }
}
