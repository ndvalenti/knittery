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
                                // TODO: Change to LazyHStack, resolve loading issues (same id?)
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
                                Text(notes)
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
                    }
                    .background(Color.KnitteryColor.backgroundLight)
                }
            } header: {
                HStack {
                    VStack(alignment: .leading) {
                        if let name = patternDetailsViewModel.pattern.name {
                            Text(name)
                                .font(.custom("SF Pro", size: 22, relativeTo: .largeTitle))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                        }
                        if let author = patternDetailsViewModel.pattern.author {
                            Text("By \(author.name!)")
                                .font(.custom("SF Pro", size: 18, relativeTo: .largeTitle))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
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
                    Text(row)
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
