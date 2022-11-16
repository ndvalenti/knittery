//
//  PatternDetailsView.swift
//  Knittery
//
//  Created by Nick on 2022-11-14.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternDetailsView: View {
    @State var pattern: Pattern
    
    // TODO: Is it possible to hide the titlebar when we've scrolled down and still have it over our section header?
    var body: some View {
        VStack(alignment: .leading) {
            TitleBar("Pattern")
            Section {
                ScrollView {
                    LazyVStack (alignment: .leading, pinnedViews: .sectionHeaders) {
                        Section {
                            ScrollView (.horizontal) {
                                HStack {
                                    // TODO: HStack has a limited number of elements, look into LazyHStack or horizontal Lists?
                                    ForEach(pattern.photos, id: \.self.id) { photo in
                                        AsyncImage(url: photo.squareURL, content: { image in
                                            image
                                                .resizable()
                                                .frame(width: 150, height: 150)
                                        }, placeholder: {
                                            Rectangle().frame(width: 150, height: 150)
                                                .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                        })
                                        .onTapGesture {
                                            // open photo.mediumURL modally
                                        }
                                    }
                                }
                                .frame(height: 150)
                                // TODO: Good place for wishlist/favorite buttons
                            }
                        }
                        Section {
                            VStack (alignment: .leading) {
                                Group {
                                    makeRow("Craft", content: [pattern.craft.name!])
                                    Divider()
                                }
                                Group {
                                    makeRow("Published", content: [pattern.createdAt!])
                                    Divider()
                                }
                                Group {
                                    makeRow("Yardage", content: [String(pattern.yardage!)])
                                    Divider()
                                }
                                Group {
                                    makeRow("Yarn weight", content: ["\(pattern.yarnWeight.name!) (\(pattern.yarnWeight.wpi!) wpi)"])
                                    Divider()
                                }
                                Group {
                                    makeRow("Needle sizes", content: [pattern.needleSizes.first!.name!])
                                    Divider()
                                }
                                Group {
                                    makeRow("Sizes available", content: [pattern.sizesAvailable!])
                                }
                            }
//                            .padding(.horizontal)
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
                            Text(pattern.notes!)
                                .padding(.horizontal)
                                .background(Color.KnitteryColor.backgroundLight)
                                .foregroundColor(.KnitteryColor.darkBlue)
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
                        if let name = pattern.name {
                            Text(name)
                                .font(.custom("SF Pro", size: 22, relativeTo: .largeTitle))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                        }
                        if let author = pattern.author {
                            Text("By \(author.name!)")
                                .font(.custom("SF Pro", size: 18, relativeTo: .largeTitle))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                        }
                        // TODO: Not a bad place for rating/difficulty
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
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
        PatternDetailsView(pattern: Pattern.mockData)
    }
}
