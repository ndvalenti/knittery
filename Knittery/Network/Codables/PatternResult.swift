//
//  PatternSearch.swift
//  Knittery
//
//  Created by Nick on 2022-10-11.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct PatternSearch: Codable {
    let patterns: [PatternResult]
    
    init(patterns: [PatternResult]) {
        self.patterns = patterns
    }
}

struct PatternResult: Codable {
    let free: Bool?
    let id: Int?
    let name: String?
    let firstPhoto: Photo?
    let author: Author?
    let designer: Designer?
    
    enum CodingKeys: String, CodingKey {
        case firstPhoto = "first_photo"
        case author = "pattern_author"
        case free, id, name, designer
    }
    
    init(free: Bool?, id: Int?, name: String?, firstPhoto: Photo?, author: Author?, designer: Designer?) {
        self.free = free
        self.id = id
        self.name = name
        self.firstPhoto = firstPhoto
        self.author = author
        self.designer = designer
    }
}

extension PatternSearch {
    static let mockData = PatternSearch(patterns: [PatternResult.mockData])
}

extension PatternResult{
    static let mockData = PatternResult(free: true,
                                        id: 1234,
                                        name: "Sample Pattern",
                                        firstPhoto: Photo.mockData,
                                        author: Author.mockData,
                                        designer: Designer.mockData)
}
