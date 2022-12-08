//
//  LibraryView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var libraryViewModel = LibraryViewModel()
    @EnvironmentObject var sessionData: SessionData
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 50) {
                            KnitteryPatternPreviewBlock()
                        }
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity)
                .background(Color.KnitteryColor.backgroundLight)
            }
            .frame(maxWidth: .infinity)
            .background(Color.KnitteryColor.backgroundDark)
            .toolbar {
                NavigationToolbar(title: "Library", sessionData: sessionData)
            }
            .toolbar(.visible, for: .navigationBar)
        }
        .environmentObject(sessionData)
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
            .environmentObject(SessionData())
    }
}
