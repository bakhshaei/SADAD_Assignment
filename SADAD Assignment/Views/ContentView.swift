//
//  ContentView.swift
//  SADAD Assignment
//
//  Created by Amin on 11/2/23.
//

import SwiftUI

struct ContentView: View {
    // List of MediaModel to show on on the page.
    var mediaList : Array<MediaModel> = []
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List(mediaList) { rowData in
                    NavigationLink {
                        // Link Next page, which shows after tapping on each row.
                        Text(rowData.getDetailViewdescription)
                    } label: {
                        // View of each row in List
                        MediaRowView(rowModel: rowData)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(mediaList: [.sampleImage, .sampleVideo])
}
