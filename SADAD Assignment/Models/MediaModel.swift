//
//  MediaModel.swift
//  SADAD Assignment
//
//  Created by Amin on 11/3/23.
//

import Foundation

struct MediaModel: Codable {
    var title: String?
    var type: String?
    var previewLink: String?
    var mediaLink: String?
    
    enum MediaType: String {
        case image
        case video
    }
}

let sample = """
{
        "title": "Text 1",
        "type": "image",
        "previewLink": "https://wallpapershome.com/images/pages/ico_h/25371.jpg",
        "mediaLink": "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
    },
{
        "title": "Text 3",
        "type": "video",
        "previewLink": "https://wallpapershome.com/images/pages/ico_v/25365.jpg",
        "mediaLink": "https://cdn.coverr.co/videos/coverr-palm-tree-landscape-3016/1080p.mp4"
    }
"""
