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
    let uuid = UUID()
    let id: Int?
    let name: String?
    let longname: String?
    let permalink: String?
    let children: [PatternCategory]?
    
    var flatChildren: [PatternCategory]? {
        getFlatChildren(self)
    }
    
    // Is this a linkable copy of its parent for list formatting requirements
    var ghostCategory: Bool
    
    init(id: Int? = nil, name: String? = nil, longname: String? = nil, permalink: String? = nil, children: [PatternCategory]? = nil, ghostCategory: Bool = false) {
        self.id = id
        self.name = name
        self.longname = longname
        self.permalink = permalink
        self.children = children
        self.ghostCategory = ghostCategory
    }
    
    // We need a custom decoder to convert empty children arrays to nil
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int?.self, forKey: .id) ?? nil
        name = try values.decodeIfPresent(String?.self, forKey: .name) ?? nil
        longname = try values.decodeIfPresent(String?.self, forKey: .longname) ?? nil
        permalink = try values.decodeIfPresent(String?.self, forKey: .permalink) ?? nil
        ghostCategory = try values.decodeIfPresent(Bool.self, forKey: .ghostCategory) ?? false
        
        do {
            let container = try values.decode([PatternCategory]?.self, forKey: .children)
            if let container, container.isEmpty == false {
                let ghostParent = PatternCategory(id: id, name: name, longname: longname, permalink: permalink, children: nil, ghostCategory: true)
                if container.contains(where: { $0.id == ghostParent.id } ) {
                    children = container
                } else {
                    children = [ghostParent] + container
                }
            } else {
                children = nil
            }
        } catch {
            children = nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case longname = "long_name"
        case id, name, permalink, children, ghostCategory
    }
}

extension PatternCategory {
    // This list is curated based on the ravelry homepage
    // These ids should not change but should also not be relied on to exist and need to be manually checked from time to time
    static let defaultIDList = [372, 364, 304, 340, 482, 325, 515, 395, 411, 427, 391, 565, 306, 339, 350, 305, 313, 363, 354, 520, 319, 912, 310]
    
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
            if !child.ghostCategory {
                let pruned = PatternCategory(id: child.id, name: child.name, longname: child.longname, permalink: child.permalink)
                flatArray.append(pruned)
                
                let recurseResult = getFlatChildren(child.children) ?? []
                flatArray.append(contentsOf: recurseResult)
            }
        }
        return flatArray
    }
}
