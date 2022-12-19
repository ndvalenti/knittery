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
    
    @State private var hasLoaded = false
    @State private var isSheetPresented: Bool = false
    @State private var displayedPhoto: Int? = nil
    
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
                                            displayedPhoto = photo.id
                                            isSheetPresented = true
                                        }
                                    }
                                } else {
                                    ForEach (0..<5) { placeholder in
                                        Rectangle().frame(width: 150, height: 150)
                                            .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                    }
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Section {
                            PatternDetailsBlockView(patternDetailsViewModel: patternDetailsViewModel, isPresentingDownload: $patternDetailsViewModel.isPresentingDownload)
                        } header: {
                            HStack {
                                Text("Details")
                                    .font(.headline)
                                    .padding(.vertical)
                                    .padding(.leading)
                                Spacer()
                                if let rating = patternDetailsViewModel.pattern.rating, rating > 0.0 {
                                    Label {
                                        Text("\(rating, specifier: "%.2f")")
                                            .foregroundColor(.KnitteryColor.darkBlueHalfTranslucent)
                                    } icon: {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.KnitteryColor.yellow)
                                            .overlay {
                                                Image(systemName: "star")
                                                    .foregroundColor(.KnitteryColor.darkBlueTranslucent)
                                            }
                                    }
                                    .padding(.trailing)
                                }
                            }
                        }
                        .background(Color.KnitteryColor.backgroundDark)
                        Section {
                            Text(LocalizedStringKey(patternDetailsViewModel.pattern.notes ?? .lipsum))
                                .padding(.horizontal)
                                .padding(.bottom, 200)
                                .background(Color.KnitteryColor.backgroundLight)
                                .foregroundColor(.KnitteryColor.darkBlue)
                                .redacted(reason: patternDetailsViewModel.pattern.id == nil ? .placeholder : [])
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
                HStack(alignment: .top) {
                    KnitteryFavoriteButton(
                        isSelected: $patternDetailsViewModel.isFavorited,
                        action: {
                            patternDetailsViewModel.toggleFavorite(username: sessionData.currentUser?.username)
                            sessionData.invalidateDefaultQuery(.favoritePatterns)
                        })
                    VStack(alignment: .leading) {
                        Text(patternDetailsViewModel.pattern.name ?? .placeholder(length: Int.random(in: 5...20)))
                            .font(.custom("SF Pro", size: 22, relativeTo: .headline))
                            .foregroundColor(Color.KnitteryColor.darkBlue)
                        Text(patternDetailsViewModel.pattern.author?.name ?? .placeholder(length: Int.random(in: 8...23)))
                            .font(.custom("SF Pro", size: 18, relativeTo: .subheadline))
                            .foregroundColor(Color.KnitteryColor.darkBlue)
                    }
                    .redacted(reason: patternDetailsViewModel.pattern.id == nil ? .placeholder : [])
                    Spacer()
                }
                .padding(.leading)
                .padding(.vertical)
                .background(Color.KnitteryColor.backgroundDark)
            }
            .background(Color.KnitteryColor.backgroundLight)
            .sheet(isPresented: $isSheetPresented) {
                if let photos = patternDetailsViewModel.pattern.photos {
                    TabView(selection: $displayedPhoto) {
                        ForEach(photos, id: \.self.sortOrder) { photo in
                            AsyncImage(url: photo.medium2URL, content: { image in
                                image
                            }, placeholder: {
                                ProgressView()
                            })
                            .tabItem {}
                            .tag(photo.id)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
                }
            }
            .sheet(isPresented: $patternDetailsViewModel.isPresentingDownload) {
                VStack {
                    HStack {
                        Text("FILES:")
                            .font(.subheadline)
                            .foregroundColor(.KnitteryColor.darkBlueHalfTranslucent)
                            .padding([.horizontal, .top])
                        Spacer()
                    }
                    if patternDetailsViewModel.downloadLink.isEmpty {
                        List {
                            if let urlString = patternDetailsViewModel.downloadURL, let url = URL(string: urlString) {
                                HStack {
                                    Link("Free On Ravelry", destination: url)
                                        .foregroundColor(.KnitteryColor.lightBlue)
                                        .lineLimit(1)
                                        .padding(.leading)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.KnitteryColor.lightBlue)
                                }
                            }
                        }
                    } else {
                        List (patternDetailsViewModel.downloadLink, id: \.url) { link in
                            if let urlString = link.url, let url = URL(string: urlString) {
                                HStack {
                                    Link(link.filename ?? urlString, destination: url)
                                        .foregroundColor(.KnitteryColor.lightBlue)
                                        .lineLimit(3)
                                        .padding(.leading)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.KnitteryColor.lightBlue)
                                }
                            }
                        }
//                        Text("Note: Fetching premium content requires Ravelry reauthentication")
//                            .font(.footnote)
//                            .padding()
//                        Spacer()
                    }
                }
                .padding(.top)
                .listStyle(.inset)
                .presentationDetents([.fraction(0.35), .medium, .large])
            }
        }
        .onAppear() {
            if !hasLoaded {
                patternDetailsViewModel.sessionData = sessionData
                if let id = sessionData.libraryItems?.getVolumeIdByPatternId(patternId) {
                    patternDetailsViewModel.libraryId = id
                }
                patternDetailsViewModel.retrievePattern(patternId: patternId)
                hasLoaded = true
            }
        }
        .navigationTitle("Pattern Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            NavigationToolbar(sessionData: sessionData)
        }
    }
}

struct PatternDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternDetailsView(nil)
            .environmentObject(SessionData())
    }
}
