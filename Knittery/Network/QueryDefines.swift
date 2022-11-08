//
//  QueryDefines.swift
//  Knittery
//
//  Created by Nick on 2022-10-13.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

protocol SearchOption: RawRepresentable {
    static var allCases: Array<Self> { get }
    var displayName: String? { get }
}

enum SearchOptionCategory: CaseIterable {
    case notebook
    case craft
    case sort
    case availability
    case weight

    var display: String {
        switch self {
        case .notebook: return "Notebook"
        case .craft: return "Craft"
        case .sort: return "Sort"
        case .availability: return "Availability"
        case .weight: return "Weight"
        }
    }
}

// notebook-p
enum QNotebook: String, CaseIterable, SearchOption {
    case favorites = "faved"
    case projects = "projects"
    case queued = "queued"
    case library = "library"
    case favoriteDesigners = "favedesigners"
    case stashed = "stashed"
    case viewed = "viewed"
    case ignored = "ignored"
    
    static var categoryName = "Notebook"
    
    var displayName: String? {
        switch self {
        case .favorites: return "Favorites"
        case .projects: return "Projects"
        case .queued: return "Queued"
        case .library: return "Library"
        case .favoriteDesigners: return "Favorite Designers"
        case .stashed: return "Stashed"
        case .viewed: return "Viewed"
        case .ignored: return "Ignored"
        }
    }
}

// craft
enum QCraft: String, CaseIterable, SearchOption {
    case crochet = "crochet"
    case knitting = "knitting"
    case machineKnitting = "machine-knitting"
    case loomKnitting = "loom-knitting"
    
    static var categoryName = "Craft"
    
    var displayName: String? {
        switch self {
        case .crochet: return "Crochet"
        case .knitting: return "Knitting"
        case .machineKnitting: return "Machine Knitting"
        case .loomKnitting: return "Loom Knitting"
        }
    }
}

// sort
enum QSort: String, CaseIterable, SearchOption {
    case best = "best"
    case recent = "recently-popular"
    case newest = "created"
    case az = "name"
    case randomize = "randomize"
    case popular = "popular"
    case projects = "projects"
    case favorites = "favorites"
    case queues = "queues"
    case pubdate = "date"
    case rating = "rating"
    case difficulty = "difficulty"
    case yarn = "yarn"
    
    static let categoryName = "Sort"
    
    var displayName: String? {
        switch self {
        case .best: return "Best"
        case .recent: return "Popular"
        case .newest: return "New"
        case .az: return "A-Z"
        case .randomize: return nil
        case .popular: return "Popularity"
        case .projects: return nil
        case .favorites: return nil
        case .queues: return nil
        case .pubdate: return "Publication Date"
        case .rating: return "Rating"
        case .difficulty: return "Difficulty"
        case .yarn: return nil
        }
    }
}

// availability
enum QAvailability: String, CaseIterable, SearchOption {
    case nocost = "free"
    case purchaseOnline = "online"
    case purchasePrint = "inprint"
    case ravelryDownload = "ravelry"
    case library = "library"
    case discontinued = "discontinued"
    
    static let categoryName: String = "Availability"
    
    var displayName: String? {
        switch self {
        case .nocost: return "Free"
        case .purchaseOnline: return "Purchase Online"
        case .purchasePrint: return "Purchase Print"
        case .ravelryDownload: return "Ravelry Download"
        case .library: return "In Library"
        case .discontinued: return nil
        }
    }
}

// weight
enum QWeight: String, CaseIterable, SearchOption {
    case anyWeight = "any"
    case threadWeight = "thread"
    case cobweb = "cobweb"
    case lace = "lace"
    case lightFingering = "light-fingering"
    case fingering = "fingering"
    case sport = "sport"
    case dk = "dk"
    case worsted = "worsted"
    case aran = "aran"
    case bulky = "bulky"
    case superBulky = "super-bulky"
    case jumbo = "jumbo"
    case notSpecified = "unknown"
    
    static let categoryName = "Weight"
    
    var displayName: String? {
        switch self {
        case .anyWeight: return nil
        case .threadWeight: return "Thread"
        case .cobweb: return "Cobweb"
        case .lace: return "Lace"
        case .lightFingering: return "Light Fingering"
        case .fingering: return "Fingering"
        case .sport: return "Sport"
        case .dk: return "DK"
        case .worsted: return "Worsted"
        case .aran: return "Aran"
        case .bulky: return "Bulky"
        case .superBulky: return "Super Bulky"
        case .jumbo: return "Jumbo"
        case .notSpecified: return nil
        }
    }
}

// TODO: the following categories require special handling, are overcomplicated, or must be fetched and built programatically
// pc
//enum QCategory: String {
//
//}

// pa
//enum QAttributes: String {
//
//}

// fit
//enum QAgeSizeFit: String {
//
//}
