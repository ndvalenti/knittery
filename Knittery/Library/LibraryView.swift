//
//  LibraryView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var libraryViewModel = LibraryViewModel()
    
    var body: some View {
        VStack {
            TitleBar("Library")
            Button {
                testAPI()
            } label: {
                Text("Test API")
            }
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
    
    func testAPI() {
        libraryViewModel.testAPICall()
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
