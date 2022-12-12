//
//  HomeView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var sessionData: SessionData
    let previewQueries: [DefaultQuery] = [.hotPatterns, .debutPatterns, .randomPatterns, .newPatterns]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        ForEach (previewQueries, id: \.rawValue) { query in
                            PatternSearchRowView(query.rawValue, results: $sessionData.defaultQueries[query])
                                .environmentObject(sessionData)
                        }
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color.KnitteryColor.backgroundLight)
            }
            .frame(maxWidth: .infinity)
            .toolbar {
                NavigationToolbar(title: "Home", sessionData: sessionData)
            }
            .toolbar(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.KnitteryColor.backgroundDark)
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

struct YarnsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionData())
    }
}
