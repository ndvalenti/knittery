//
//  PatternDetailsBlockView.swift
//  Knittery
//
//  Created by Nick on 2022-11-27.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternDetailsBlockView: View {
    @ObservedObject var patternDetailsViewModel: PatternDetailsViewModel
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack (alignment: .leading) {
            Group {
                if let craft = patternDetailsViewModel.pattern.craft {
                    makeRow("Craft", content: craft.toString)
                }
            }
            Group {
                if let created = patternDetailsViewModel.pattern.createdAtDate {
                    Divider()
                    makeRow("Published", content: formatDate(created))
                }
            }
            Group {
                if let yardage = patternDetailsViewModel.pattern.yardage {
                    Divider()
                    makeRow("Yardage", content: String(yardage))
                }
            }
            Group {
                if let weight = patternDetailsViewModel.pattern.yarnWeight {
                    Divider()
                    makeRow("Yarn weight", content: weight.toString)
                }
            }
            Group {
                if let sizes = patternDetailsViewModel.pattern.needleSizes {
                    let sizeArray = sizes.map { $0.toString }
                    Divider()
                    makeRow("Needle sizes", content: sizeArray)
                }
            }
            Group {
                if let available = patternDetailsViewModel.pattern.sizesAvailable {
                    Divider()
                    makeRow("Sizes available", content: available)
                }
            }
            Group {
                // If this pattern is in your library or free display the link, else skip it
                if let downloadLocation = patternDetailsViewModel.pattern.downloadLocation {
                    if let url = downloadLocation.url {
                        if (patternDetailsViewModel.pattern.personalAttributes?.inLibrary ?? false) {
                            Divider()
                            makeRow("URL", content: url)
                        } else if downloadLocation.free ?? false {
                            Divider()
                            makeRow("URL", content: url)
                        }
                    }
                }
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
    
    func formatDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
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

struct PatternDetailsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        PatternDetailsBlockView(patternDetailsViewModel: PatternDetailsViewModel())
    }
}

//struct StarsView: View {
//    var rating: CGFloat
//    var maxRating: Int
//
//    var body: some View {
//        let stars = HStack(spacing: 0) {
//            ForEach(0..<maxRating, id: \.self) { _ in
//                Image(systemName: "star.fill")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(.KnitteryColor.backgroundDark)
//            }
//        }
//
//        stars.overlay(
//            GeometryReader { g in
//                let width = rating / CGFloat(maxRating) * g.size.width
//                ZStack(alignment: .leading) {
//                    Rectangle()
//                        .frame(width: width)
//                        .foregroundColor(.KnitteryColor.yellow)
//                }
//            }
//                .mask(stars)
//        )
//    }
//}
