//
//  PatternDetailsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-22.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Combine
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
    var sessionData: SessionData?
    
    private var networkHandler = NetworkHandler()

    private var cancellables = Set<AnyCancellable>()
    
    func retrievePattern(patternId: Int?) {
        if let patternId  {
            NetworkHandler.requestPatternById(patternId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error fetching patterns search: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] pattern in
                    self?.pattern = pattern
                    self?.isFavorited = pattern.personalAttributes?.favorited ?? false
                    self?.bookmarkId = pattern.personalAttributes?.bookmarkId
                })
                .store(in: &cancellables)
        }

        if let libraryId {
            NetworkHandler.requestLibraryVolumeFull(id: String(libraryId)) { [weak self] (result: Result<LibraryVolumeFull, ApiError>) in
                switch result {
                case .success(let volume):
                    DispatchQueue.main.async {
                        self?.libraryVolumeFull = volume
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getDownloadLinks() {
        if let downloadLocation = pattern.downloadLocation {
            if pattern.personalAttributes?.inLibrary == true {
                retrieveDownloadLink()
            } else if downloadLocation.free == true, let url = downloadLocation.url {
                downloadURL = url
                isPresentingDownload = true
            }
        }
    }
    
    private func retrieveDownloadLink() {
        if let patternId = pattern.id, let attachments = libraryVolumeFull?.attachments {
            downloadLink.removeAll()
            
            attachments.forEach { attachment in
                guard let id = attachment.attachmentId else { return }
                
                NetworkHandler.requestDownloadLinkById(id) { [weak self] (result: Result<DownloadLink, ApiError>) in
                    switch result {
                    case .success (let link):
                        DispatchQueue.main.async {
                            self?.downloadLink.append(DownloadLink(link, patternID: patternId, filename: attachment.filename))
                            self?.isPresentingDownload = true
                        }
                    case .failure (let error):
                        if error == .badToken || error == .noToken || error == .invalidResponse {
                            print(error)
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
                            self?.downloadLink.append(DownloadLink(link, patternID: patternId, filename: attachment.filename))
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
            NetworkHandler.deleteFavorite(bookmarkId: String(bookmarkId), username: username)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Error deleting bookmark: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] _ in
                    self?.bookmarkId = nil
                    self?.isFavorited = false
					self?.sessionData?.populateDefaultQuery(.favoritePatterns)
                })
                .store(in: &cancellables)

        case false:
            guard let patternId = pattern.id else { return }
            NetworkHandler.addFavorite(patternId: String(patternId), username: username)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Error creating bookmark: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] bookmark in
                    self?.bookmarkId = bookmark.id
                    self?.isFavorited = true
					self?.sessionData?.populateDefaultQuery(.favoritePatterns)
                })
                .store(in: &cancellables)
        }
    }
}
