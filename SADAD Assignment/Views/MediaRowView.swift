//
//  MediaRowView.swift
//  SADAD Assignment
//
//  Created by Amin on 11/4/23.
//

import SwiftUI

struct MediaRowView: View {
    
    @StateObject var imageLoader = ImageLoaderManager()
    var rowModel: MediaModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Image
            switch imageLoader.state {
            case .notInializedProperly, .initialized:
                Image(systemName: "photo.artframe", variableValue: 0.5)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.secondary.opacity(0.4), .primary.opacity(0.4))
                    .padding(.horizontal)
                    .frame(maxWidth: 200)
                
            case .loading:
                ProgressView {
                    Text("loading...")
                        .font(.caption)
                }
                .padding(.bottom, 40)
                
            case .successfullyLoaded(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                
            case .failed(_):
                Button {
                    Task {
                        await imageLoader.retryLoading()
                    }
                } label: {
                    VStack(alignment: .center) {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .secondary)
                            .frame(maxWidth: 40)
                        Text("Failed to load image.")
                    }
                    .foregroundColor(.secondary)
                    .padding(.bottom, 40)
                    
                }
            }
            
            // Bottom Section
            HStack {
                Spacer()
                // Bottom Title
                Text(rowModel.title ?? "" )
                    .font(.title3)
                    .padding(.vertical, 5)
                Spacer()
            }
            .background(.white.opacity(0.4))
            .overlay(alignment: .trailing) {
                if rowModel.type == .video {
                    // Play Button for `video` type
                    Image(systemName: "play.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing, 20)
                        .padding(.vertical, 10)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .task {
            if let previewLink = rowModel.previewLink {
                await imageLoader.setURL(url: previewLink)
            }
        }
    }
}

#Preview {
    MediaRowView(rowModel: .sampleImage)
}
