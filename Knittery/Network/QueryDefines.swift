//
//  QueryDefines.swift
//  Knittery
//
//  Created by Nick on 2022-10-13.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

// notebook-p
enum QNotebook: String {
    case favorites = "faved"
    case projects = "projects"
    case queued = "queued"
    case library = "library"
    case favoriteDesigners = "favedesigners"
    case stashed = "stashed"
    case viewed = "viewed"
    case ignored = "ignored"
}

// craft
enum QCraft: String {
    case crochet = "crochet"
    case knitting = "knitting"
    case machineKnitting = "machine-knitting"
    case loomKnitting = "loom-knitting"
}

// sort
enum QSort: String {
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
}

// availibility
enum QAvailability: String {
    case nocost = "free"
    case purchaseOnline = "online"
    case purchasePrint = "inprint"
    case ravelryDownload = "ravelry"
    case library = "library"
    case discontinued = "discontinued"
}

// weight
enum QWeight: String {
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
}

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
