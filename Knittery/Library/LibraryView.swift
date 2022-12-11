//
//  LibraryView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var sessionData: SessionData
    @Binding var tabID: TabID
    @State var empty = true
    let previewQueries: [DefaultQuery] = [.favoritePatterns, .libraryPatterns]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    if empty {
                        Button {
                            tabID = .search
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(maxHeight: 200)
                                    .foregroundColor(Color.KnitteryColor.backgroundDark)
                                VStack {
                                    Text("There doesn't seem to be anything here yet")
                                        .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                        .padding()
                                    Text("Get started")
                                        .padding()
                                        .frame(width: 200, height: 30)
                                        .foregroundColor(.white)
                                        .background(Color.KnitteryColor.lightBlue)
                                        .cornerRadius(48)
                                        .font(.custom("Avenir", size: 20, relativeTo: .largeTitle))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.KnitteryColor.darkBlueTranslucent, lineWidth: 1))
                        }
                        .padding()
                        Spacer()
                    } else {
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
                    if let current = sessionData.defaultQueries[query] {
                        if !current.isEmpty { empty = false }
                    } else {
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
    @State static var tabID: TabID = .search
    
    static var previews: some View {
        LibraryView(tabID: $tabID)
            .environmentObject(SessionData())
    }
}
