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
    let previewQueries: [DefaultQuery] = [.favoritePatterns, .libraryPatterns]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 50) {
                            ForEach (previewQueries, id: \.rawValue) { query in
                                PatternSearchRowView(query.rawValue, results: $sessionData.defaultQueries[query])
                                    .environmentObject(sessionData)
                            }
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
            .onAppear {
                for query in previewQueries {
                    if sessionData.defaultQueries[query] == nil {
                        sessionData.populateDefaultQuery(query)
                    }
                }
            }
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
