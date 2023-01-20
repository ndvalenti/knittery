//
//  SessionData.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Combine
import Foundation
import UIKit

class SessionData: ObservableObject {
    @Published var defaultQueries = [DefaultContent: [PatternResult]]()
    var cancellables = Set<AnyCancellable>()
    
    // categories is a recursive tree structure that will contain all the potential searchable categories
    // These categories almost never change and when they do it's generally just display names
    // we try to cache them for 24 hours and will display some defaults that we can rely on to exist
    var allCategories: PatternCategory?
    var lastCategoryFetch: Date?
    
    var libraryItems: LibraryVolumeList?
    var networkHandler: NetworkHandler?
    
    // On app start we randomly choose a sample category from a curated list and run a query similar to our
    // defaults above, the following two variables contain relevant information
    // TODO: Make a struct to store and handle all of the following data and move these functions/variables out of SessionData
    @Published var sampleCategory: PatternCategory? = nil
    @Published var sampleCategoryQuery: Query? = nil
    @Published var sampleCategoryResults: [PatternResult]?

    @Published var relatedCategory: PatternCategory? = nil
    @Published var relatedCategoryQuery: Query? = nil
    @Published var relatedCategoryResults: [PatternResult]?
    @Published var relatedCategoryTrigger: String?
    
    weak var signOutDelegate: SignOutDelegate?
    
    init() {
        lastCategoryFetch = UserDefaults.standard.object(forKey: "categoriesFetched") as? Date
        self.networkHandler = nil
    }
    
    @Published var currentUser: User? { didSet {
        guard let currentUser, let photoURL = currentUser.photoURL else {
            profilePicture = nil
            return
        }
        
        NetworkHandler.loadImageFrom(url: photoURL) { image in
            self.profilePicture = image
        }
    } }
    
    @Published var profilePicture: UIImage? = nil
}


