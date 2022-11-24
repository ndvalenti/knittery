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
    @State var hasLoaded = false
    @State var showImageModal: Bool = false
    
    let patternId: Int?
    let dateFormatter = DateFormatter()
    
    init(_ patternId: Int?) {
        self.patternId = patternId
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                ScrollView (showsIndicators: false) {
                    LazyVStack (alignment: .leading, pinnedViews: .sectionHeaders) {
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                if let photos = patternDetailsViewModel.pattern.photos {
                                    ForEach(photos, id: \.self.id) { photo in
                                        AsyncImage(url: photo.squareURL, content: { image in
                                            image
                                                .resizable()
                                                .frame(width: 150, height: 150)
                                        }, placeholder: {
                                            Rectangle().frame(width: 150, height: 150)
                                                .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                        })
                                        .onTapGesture {
                                            // TODO: preview photo.mediumURL modally
                                        }
                                    }
                                }
                            }
                            // TODO: Add favorite/wishlist/ratings
                        }
                        Section {
                            VStack (alignment: .leading) {
                                Group {
                                    if let craft = patternDetailsViewModel.pattern.craft {
                                        makeRow("Craft", content: craft.toString)
                                        Divider()
                                    }
                                }
                                Group {
                                    if let created = patternDetailsViewModel.pattern.createdAtDate {
                                        makeRow("Published", content: formatDate(created))
                                        Divider()
                                    }
                                }
                                Group {
                                    if let yardage = patternDetailsViewModel.pattern.yardage {
                                        makeRow("Yardage", content: String(yardage))
                                        Divider()
                                    }
                                }
                                Group {
                                    if let weight = patternDetailsViewModel.pattern.yarnWeight {
                                        makeRow("Yarn weight", content: weight.toString)
                                        Divider()
                                    }
                                }
                                Group {
                                    if let sizes = patternDetailsViewModel.pattern.needleSizes {
                                        let sizeArray = sizes.map { $0.toString }
                                        makeRow("Needle sizes", content: sizeArray)
                                        Divider()
                                    }
                                }
                                Group {
                                    if let available = patternDetailsViewModel.pattern.sizesAvailable {
                                        makeRow("Sizes available", content: available)
                                        Divider()
                                    }
                                }
                                Group {
                                    if let downloadLocation = patternDetailsViewModel.pattern.downloadLocation {
                                        if downloadLocation.free == true {
                                            if let url = downloadLocation.url {
                                                makeRow("URL", content: url)
                                            }
                                        }
                                    }
                                }
                            }
                            .background(Color.KnitteryColor.backgroundLight)
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
                    //                        HStack {
                    //                            if let rating = patternDetailsViewModel.pattern.rating {
                    //                                Text(String(rating))
                    //                                    .foregroundColor(Color.KnitteryColor.darkBlue)
                    //                                if rating > 0 {
                    //                                    StarsView(rating: rating, maxRating: 5)
                    //                                }
                    //                            }
                    //                            Spacer()
                    //                            Button {
                    //
                    //                            } label: {
                    //                                Text("Favorite")
                    //                            }
                    //                            .padding(.horizontal)
                    //                            .frame(height: 44)
                    //                            .background(Color.KnitteryColor.lightBlue)
                    //                            .foregroundColor(.white)
                    //                            .cornerRadius(26)
                    //                            Button {
                    //
                    //                            } label: {
                    //                                Text("Library")
                    //                            }
                    //                            .padding(.horizontal)
                    //                            .frame(height: 44)
                    //                            .background(Color.KnitteryColor.lightBlue)
                    //                            .foregroundColor(.white)
                    //                            .cornerRadius(26)
                    
                    Spacer()
                }
                .padding()
                .background(Color.KnitteryColor.backgroundDark)
                //                    .padding()
                //                    Spacer()
                //                }
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
        .navigationTitle("Pattern")
        .onAppear() {
            if !hasLoaded {
                patternDetailsViewModel.retrievePattern(patternId: patternId)
                dateFormatter.dateFormat = "MMMM yyyy"
                hasLoaded = true
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    func makeRow(_ title: String, content: String) -> some View {
        makeRow(title, content: [content])
    }
    
    func makeRow(_ title: String, content: [String]) -> some View {
        HStack (alignment: .top) {
            Text(title)
                .frame(width: 100, alignment: .leading)
                .foregroundColor(.KnitteryColor.darkBlue)
            Divider()
            VStack {
                ForEach(content, id: \.self) { row in
                    Text(LocalizedStringKey(row))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct PatternDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternDetailsView(nil)
    }
}

struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.KnitteryColor.backgroundDark)
            }
        }
        
        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.KnitteryColor.yellow)
                }
            }
                .mask(stars)
        )
    }
}
