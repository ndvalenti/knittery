//
//  PatternCategories.swift
//  Knittery
//
//  Created by Nick on 2022-12-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct PatternCategories: Codable {
    let rootCategory: PatternCategory?
    
    enum CodingKeys: String, CodingKey {
        case rootCategory = "pattern_categories"
    }
}

struct PatternCategory: Codable {
    let id: Int?
    let name: String?
    let longname: String?
    let permalink: String?
    let children: [PatternCategory]?
    
    var flatChildren: [PatternCategory]? {
        getFlatChildren(self)
    }

    private func getFlatChildren(_ root: PatternCategory?) -> [PatternCategory]? {
        guard let root else { return nil }
        var flatArray = [PatternCategory]()
        
        // Does not contain references to its children
        let pruned = PatternCategory(id: root.id, name: root.name, longname: root.longname, permalink: root.permalink)
        flatArray.append(pruned)
        
        flatArray.append(contentsOf: getFlatChildren(children) ?? [])
        return flatArray
    }

    private func getFlatChildren(_ root: [PatternCategory]?) -> [PatternCategory]? {
        guard let root else { return nil }
        var flatArray = [PatternCategory]()
        
        for child in root {
            let pruned = PatternCategory(id: child.id, name: child.name, longname: child.longname, permalink: child.permalink)
            flatArray.append(pruned)

            let recurseResult = getFlatChildren(child.children) ?? []
            flatArray.append(contentsOf: recurseResult)
        }
        return flatArray
    }
    
    init(id: Int? = nil, name: String? = nil, longname: String? = nil, permalink: String? = nil, children: [PatternCategory]? = nil) {
        self.id = id
        self.name = name
        self.longname = longname
        self.permalink = permalink
        self.children = children
    }
    
    // We need a custom decoder to convert empty children arrays to nil
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int?.self, forKey: .id)
        name = try values.decode(String?.self, forKey: .name)
        longname = try values.decode(String?.self, forKey: .longname)
        permalink = try values.decode(String?.self, forKey: .permalink)
        
        do {
            let container = try values.decode([PatternCategory]?.self, forKey: .children)
            children = container?.isEmpty ?? true ? nil : container
        } catch {
            children = nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case longname = "long_name"
        case id, name, permalink, children
    }
}

extension PatternCategory {
    static let defaultIDList = [372, 364, 304, 340, 482, 325, 515, 395, 411, 427, 391, 565, 306, 339, 350, 305, 313, 363, 354, 520, 319, 912, 310]
}
