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
                if let craft = patternDetailsViewModel.pattern.craft?.toString, !craft.isEmpty {
                    makeRow("Craft", content: craft)
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
                if let weight = patternDetailsViewModel.pattern.yarnWeight?.toString {
                    Divider()
                    makeRow("Yarn weight", content: weight)
                }
            }
            Group {
                if let sizes = patternDetailsViewModel.pattern.needleSizes {
                    let sizeArray = sizes.compactMap { $0.toString }
                    Divider()
                    if !sizeArray.isEmpty {
                        makeRow("Needle sizes", content: sizeArray)
                    }
                }
            }
            Group {
                if let available = patternDetailsViewModel.pattern.sizesAvailable, !available.isEmpty {
                    Divider()
                    makeRow("Sizes available", content: available)
                }
            }
            Group {
                // TODO: For now we are not generating download links for library items
                if let downloadLocation = patternDetailsViewModel.pattern.downloadLocation, let url = downloadLocation.url, downloadLocation.free == true {
                    Divider()
                    makeRow("URL", content: url)
                }
                /*
                if let downloadLocation = patternDetailsViewModel.pattern.downloadLocation {
                    if let url = downloadLocation.url {
                        if (patternDetailsViewModel.pattern.personalAttributes?.inLibrary == true) {
                            Divider()
                            makeRow("URL", content: url)
                        } else if downloadLocation.free == true {
                            Divider()
                            makeRow("URL", content: url)
                        }
                    }
                }
                */
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
