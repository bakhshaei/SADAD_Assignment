//
//  MediaModel.swift
//  SADAD Assignment
//
//  Created by Amin on 11/3/23.
//

import Foundation

struct MediaModel: Codable {
    var title: String?
    var type: MediaType
    var previewLink: String?
    var mediaLink: String?
    
    /// Available types for MediaModel
    enum MediaType: String, Codable {
        case image
        case video
    }
}

extension MediaModel: Identifiable {
    // `id` param to conforming __identifiable__,  sets as concatenation of `title` and `mediaLink` to make it unique for each model.
    var id: String {
        (title ?? "") + (mediaLink ?? "")
    }
}


extension MediaModel {
    var getDetailViewdescription: String {
        switch type {
        case .image:
            return "Displaying Image from link: \(self.mediaLink ?? "")"
        
        case .video:
            return "Playing Video from link: \(self.mediaLink ?? "")"
        }
    }
}

#if DEBUG
extension MediaModel {
    /// Sample MediaModel with `Image` type.
    static let sampleImage = MediaModel(
        title: "Text 1",
        type: .image,
        previewLink: "https://wallpapershome.com/images/pages/ico_h/25371.jpg",
        mediaLink: "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
    )
    
    /// Sample MediaModel with `Video` type.
    static let sampleVideo = MediaModel(
        title: "Text 3",
        type: .video,
        previewLink: "https://wallpapershome.com/images/pages/ico_v/25365.jpg",
        mediaLink: "https://cdn.coverr.co/videos/coverr-palm-tree-landscape-3016/1080p.mp4"
    )
}
#endif
