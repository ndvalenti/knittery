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
    @Binding var isPresentingDownload: Bool
    
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
                    if patternDetailsViewModel.pattern.downloadLocation != nil {
                        Divider()
                        HStack (alignment: .top) {
                            Spacer()
                            Button {
                                patternDetailsViewModel.getDownloadLinks()
                            } label: {
                                Label("Request Download Links", systemImage: "arrow.down.doc.fill") 
                                    .padding()
                            }
                            Spacer()
                        }
                        .redacted(reason: patternDetailsViewModel.pattern.id == nil ? .placeholder: [])
                        .padding(.horizontal)
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
        PatternDetailsBlockView(patternDetailsViewModel: PatternDetailsViewModel(), isPresentingDownload: $isPresented)
    }
}
