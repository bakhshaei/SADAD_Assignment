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
        }
        .refreshable {
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
            VStack {
                Image(systemName: "xmark.circle")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.red)
                Text("Failed to get list. \nPull to refresh or try again later.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            
        }
    }
}

#Preview {
    let previewVM = MediaListViewModel(mediaList: .success([.sampleImage, .sampleVideo]) )
    return MediaListView(viewModel: previewVM)
}
