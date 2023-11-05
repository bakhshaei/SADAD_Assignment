//
//  MediaListView.swift
//  SADAD Assignment
//
//  Created by Amin on 11/2/23.
//

import SwiftUI

struct MediaListView: View {

    /// ViewModel
    @StateObject var viewModel : MediaListViewModel = .init()
    
    var body: some View {
        
        NavigationStack {
            List {
                getMediaListRows
            }
            .navigationTitle("Media List")
        }
        .refreshable {
            viewModel.fetchList()
        }
        .task {
            viewModel.fetchList()
        }
    }
    
    
    @ViewBuilder
    private var getMediaListRows: some View {
        switch viewModel.mediaList {
        case .success(let list):
            ForEach(list) { rowData in
                NavigationLink {
                    // Link Next page, which shows after tapping on each row.
                    Text(rowData.getDetailViewdescription)
                } label: {
                    // View of each row in List
                    MediaRowView(rowModel: rowData)
                }
            }
        case .failure(_):
            VStack(alignment: .center) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.red)
                    .frame(maxWidth: 40)
                Text("Failed to get list. \nPull to refresh or try again later.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
        }
    }
}

#Preview {
    let previewVM = MediaListViewModel(mediaList: .success([.sampleImage, .sampleVideo]) )
    return MediaListView(viewModel: previewVM)
}
