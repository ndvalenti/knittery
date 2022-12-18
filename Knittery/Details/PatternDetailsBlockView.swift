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
    @Binding var isDownloadPresented: Bool
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack (alignment: .leading) {
            if patternDetailsViewModel.pattern.id != nil {
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
                    // Requires special handling including paypal sdk and integration with applepay
                    // and testing with correctly capturing the callbacks and using special
                    // auth to generate download links
                    //                    if let downloadLocation = patternDetailsViewModel.pattern.downloadLocation, let url = downloadLocation.url, downloadLocation.free == true {
                    //                        Divider()
                    //                        makeRow("URL", content: url)
                    //                    }
                    
                    // TODO: Library download links
                    // Download links need to be added to codables -- done, need to confirm it works with jsonencoding for userdefaults and check if pattern urls are updated
                    // Should have a way here to generate a link if it's in library and not free
                    // Click "Download" and a modal popup with a download button will show?
                    // Modal can also display rate excess
                    // Should display the link if it has been generated and is not expired
                    // Download link codable should save its associated patternid though not necessarily when attached to a pattern
                    // Download links should be stored in UserDefaults and expired links pruned at launch and every time an expired link is encountered
                    
                    
                    if let downloadLocation = patternDetailsViewModel.pattern.downloadLocation {
                        if patternDetailsViewModel.pattern.personalAttributes?.inLibrary == true {
                            Divider()
                            HStack (alignment: .top) {
                                Button {
                                    patternDetailsViewModel.retrieveDownloadLink()
                                } label: {
                                    Text("Download")
                                        .frame(width: 100, alignment: .leading)
                                        .foregroundColor(.KnitteryColor.darkBlue)
                                }
                            }
                            .redacted(reason: patternDetailsViewModel.pattern.id == nil ? .placeholder : [])
                            .padding(.horizontal)
                        } else if downloadLocation.free == true, let url = downloadLocation.url {
                            Divider()
                            HStack (alignment: .top) {
                                Button {
                                    patternDetailsViewModel.downloadURL = url
                                    isDownloadPresented = true
                                } label: {
                                    Text("Download")
                                        .frame(width: 100, alignment: .leading)
                                        .foregroundColor(.KnitteryColor.darkBlue)
                                }
                            }
                            .redacted(reason: patternDetailsViewModel.pattern.id == nil ? .placeholder : [])
                            .padding(.horizontal)
                        }
                    }
                    
                }
            } else {
                ForEach(0..<5) { placeholder in
                    makeRow(.placeholder(length: Int.random(in: 3...8)), content: .placeholder(length: Int.random(in: 7...35)))
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
        .redacted(reason: patternDetailsViewModel.pattern.id == nil ? .placeholder : [])
        .padding(.horizontal)
    }
}

struct PatternDetailsBlockView_Previews: PreviewProvider {
    @State static var isPresented: Bool = false
    static var previews: some View {
        PatternDetailsBlockView(patternDetailsViewModel: PatternDetailsViewModel(), isDownloadPresented: $isPresented)
    }
}
