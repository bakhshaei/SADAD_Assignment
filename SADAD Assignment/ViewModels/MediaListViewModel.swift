//
//  MediaListViewModel.swift
//  SADAD Assignment
//
//  Created by Amin on 11/4/23.
//

import Foundation
import Combine

class MediaListViewModel: ObservableObject {
    
    //MARK: - Parameters
    
    /// List of MediaModel to show on on the page.
    @Published var mediaList : Result<Array<MediaModel>,Error>
    
    /// The service used to provide data
    private var mediaService : MediaListServiceProtocol
    
    
    private var cancellableSet : Set<AnyCancellable> = []
    
    
    //MARK: - Initialiazer
    init(
        mediaList: Result<Array<MediaModel>,Error> = .success([]),
        mediaService: MediaListServiceProtocol = MediaListService()
    ) {
        self.mediaList = mediaList
        self.mediaService = mediaService
    }
    
    //MARK: - Methods
    func fetchList() {
        mediaService.fetchMediaList()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.mediaList = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { list in
                self.mediaList = .success(list)
            }
            .store(in: &cancellableSet)

    }
}
