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
            Text("Library")
            Button {
                testAPI()
            } label: {
                Text("Test API")
            }
        }
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
