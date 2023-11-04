//
//  MediaRowView.swift
//  SADAD Assignment
//
//  Created by Amin on 11/4/23.
//

import SwiftUI

struct MediaRowView: View {
    var rowModel: MediaModel
    var body: some View {
        ZStack(alignment: .bottom) {

            AsyncImage(url: URL(string: rowModel.previewLink ?? "")) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.5)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    Image(systemName: "cross")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.red)
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.5)
                }
            }
            
            HStack {
                Spacer()
                Text(rowModel.title ?? "" )
                    .font(.title)
                    .padding(.vertical, 5)
                Spacer()
            }
            .background(.white.opacity(0.4))
            .overlay(alignment: .trailing) {
                if rowModel.type == .video {
                    Image(systemName: "play.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing, 20)
                        .padding(.vertical, 10)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

#Preview {
    MediaRowView(rowModel: .sampleImage)
}
