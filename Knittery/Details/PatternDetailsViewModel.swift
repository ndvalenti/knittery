//
//  PatternDetailsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-22.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class PatternDetailsViewModel: ObservableObject {
    @Published var pattern = Pattern.emptyData
    @Published var isFavorited: Bool = false
    @Published var bookmarkId: Int?
    @Published var libraryId: Int?
    @Published var libraryVolumeFull: LibraryVolumeFull?
    @Published var downloadLink: [DownloadLink] = []
    @Published var isPresentingDownload: Bool = false
    @Published var downloadURL: String?
    
    private var networkHandler = NetworkHandler()
    
    func retrievePattern(patternId: Int?) {
        if let patternId  {
            NetworkHandler.requestPatternById(patternId) { [weak self] (result: Result<Pattern, ApiError>) in
                switch result {
                case .success (let pattern):
                    DispatchQueue.main.async {
                        self?.pattern = pattern
                        self?.isFavorited = pattern.personalAttributes?.favorited ?? false
                        self?.bookmarkId = pattern.personalAttributes?.bookmarkId
                    }
                case .failure (let error):
                    print(error)
                }
            }
            
            if let libraryId {
                NetworkHandler.requestLibraryVolumeFull(id: String(libraryId)) { [weak self] (result: Result<LibraryVolumeFull, ApiError>) in
                    switch result {
                    case .success(let volume):
                        DispatchQueue.main.async {
                            self?.libraryVolumeFull = volume
                            print(volume)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func retrieveDownloadLink() {
        if let patternId = pattern.id, let attachments = libraryVolumeFull?.attachments {
            downloadLink.removeAll()
            
            attachments.forEach { attachment in
                guard let id = attachment.attachmentId else { return }
                
                NetworkHandler.requestDownloadLinkById(id) { [weak self] (result: Result<DownloadLink, ApiError>) in
                    switch result {
                    case .success (let link):
                        DispatchQueue.main.async {
                            self?.downloadLink.append(DownloadLink(link, patternID: patternId))
                            self?.isPresentingDownload = true
                        }
                    case .failure (let error):
                        if error == .badToken || error == .noToken {
                            DispatchQueue.main.async {
                                self?.networkHandler.requestLibraryToken() { [weak self] success in
                                    if success {
                                        self?.retrieveDownloadLinkNoReauth(patternId: patternId)
                                    } else {
                                        print(error)
                                    }
                                }
                            }
                        } else {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    private func retrieveDownloadLinkNoReauth(patternId: Int?) {
        if let patternId, let attachments = libraryVolumeFull?.attachments {
            attachments.forEach { attachment in
                guard let id = attachment.attachmentId else { return }
                
                NetworkHandler.requestDownloadLinkById(id) { [weak self] (result: Result<DownloadLink, ApiError>) in
                    switch result {
                    case .success (let link):
                        DispatchQueue.main.async {
                            self?.downloadLink.append(DownloadLink(link, patternID: patternId))
                            self?.isPresentingDownload = true
                        }
                    case .failure (let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func toggleFavorite(username: String?) {
        guard let username else { return }
        switch isFavorited {
        case true:
            guard let bookmarkId else { return }
            
            NetworkHandler.deleteFavorite(bookmarkId: String(bookmarkId), username: username) { [weak self] (result: Result<Bookmark, ApiError>) in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.bookmarkId = nil
                        self?.isFavorited = false
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        case false:
            guard let patternId = pattern.id else { return }
            
            NetworkHandler.addFavorite(patternId: String(patternId), username: username) { [weak self] (result: Result<Bookmark, ApiError>) in
                switch result {
                case .success(let bookmark):
                    DispatchQueue.main.async {
                        self?.bookmarkId = bookmark.id
                        self?.isFavorited = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
