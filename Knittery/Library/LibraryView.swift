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
            /*
            Button {
                print("Hej")
//                testAPI()
            } label: {
                Text("Test API")
            }
            .buttonStyle(LButton())
            List {
                NavigationLink(destination: EmptyView()) {
                    Text("One")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Two")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Three")
                }
            }
             */
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
    
    func testAPI() {
        libraryViewModel.testAPICall()
    }
}

struct LButton: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .frame(height: 41)
            .foregroundColor(.white)
            .background(Color.KnitteryColor.lightBlue)
            .cornerRadius(46)
            .font(.custom("Avenir", size: 16))
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
