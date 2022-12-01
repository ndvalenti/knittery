//
//  PatternDetailsView.swift
//  Knittery
//
//  Created by Nick on 2022-11-14.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternDetailsView: View {
    @StateObject var patternDetailsViewModel = PatternDetailsViewModel()
    @EnvironmentObject var sessionData: SessionData
    @State var hasLoaded = false
    @State var modalPhoto: Photo? = nil
    
    let patternId: Int?
    
    init(_ patternId: Int?) {
        self.patternId = patternId
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                ScrollView (showsIndicators: false) {
                    LazyVStack (alignment: .leading, pinnedViews: .sectionHeaders) {
                        ScrollView (.horizontal, showsIndicators: false) {
                            LazyHStack {
                                if let photos = patternDetailsViewModel.pattern.photos {
                                    ForEach(photos, id: \.self.sortOrder) { photo in
                                        AsyncImage(url: photo.smallURL, content: { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 150)
                                        }, placeholder: {
                                            ZStack {
                                                ProgressView()
                                                    .frame(width: 150, height: 150)
                                                Rectangle().frame(width: 150, height: 150)
                                                    .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                            }
                                        })
                                        .onTapGesture {
                                            modalPhoto = photo
                                        }
                                    }
                                }
                            }
                            // TODO: Add favorite/wishlist/ratings
                        }
                        Section {
                            PatternDetailsBlockView(patternDetailsViewModel: patternDetailsViewModel)
                        } header: {
                            HStack {
                                Text("Details")
                                    .font(.headline)
                                    .padding(.vertical)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .background(Color.KnitteryColor.backgroundDark)
                        Section {
                            if let notes = patternDetailsViewModel.pattern.notes {
                                Text(LocalizedStringKey(notes))
                                    .padding(.horizontal)
                                    .padding(.bottom, 200)
                                    .background(Color.KnitteryColor.backgroundLight)
                                    .foregroundColor(.KnitteryColor.darkBlue)
                            }
                        } header: {
                            HStack {
                                Text("Description")
                                    .font(.headline)
                                    .padding(.vertical)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .background(Color.KnitteryColor.backgroundDark)
                        // TODO: This disables click interaction with URLs since we cannot control if they are payment links
                        .allowsHitTesting(false)
                    }
                    .background(Color.KnitteryColor.backgroundLight)
                }
            } header: {
                HStack {
                    VStack(alignment: .leading) {
                        if let name = patternDetailsViewModel.pattern.name {
                            Text(name)
                                .font(.custom("SF Pro", size: 22, relativeTo: .headline))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                        }
                        if let author = patternDetailsViewModel.pattern.author {
                            Text("By \(author.name!)")
                                .font(.custom("SF Pro", size: 18, relativeTo: .subheadline))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                        }
                    }
                    Spacer()
                }
                .padding()
                .background(Color.KnitteryColor.backgroundDark)
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
        .navigationTitle("Pattern Details")
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            NavigationToolbar(sessionData: sessionData)
        }
        .onAppear() {
            if !hasLoaded {
                patternDetailsViewModel.retrievePattern(patternId: patternId)
                hasLoaded = true
            }
        }
        .sheet(item: $modalPhoto) { _ in
            if let photos = patternDetailsViewModel.pattern.photos {
                TabView(selection: $modalPhoto) {
                    ForEach(photos, id: \.self.sortOrder) { photo in
                        AsyncImage(url: photo.medium2URL, content: { image in
                            image
                        }, placeholder: {
                            ProgressView()
                        })
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

struct PatternDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternDetailsView(nil)
            .environmentObject(SessionData())
    }
}
