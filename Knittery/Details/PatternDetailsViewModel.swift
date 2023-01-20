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
            NetworkHandler.requestLibraryVolumeFull(id: String(libraryId))
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error fetching library volume: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] volume in
                    self?.libraryVolumeFull = volume
                })
                .store(in: &cancellables)
        }
    }
    
    func getDownloadLinks() {
        if let downloadLocation = pattern.downloadLocation {
            if pattern.personalAttributes?.inLibrary == true {
                retrieveDownloadLinks()
            } else if downloadLocation.free == true, let url = downloadLocation.url {
                downloadURL = url
                isPresentingDownload = true
            }
        }
    }
    
    private func retrieveDownloadLinks() {
        if let patternId = pattern.id, let attachments = libraryVolumeFull?.attachments {
            downloadLink.removeAll()
            attachments.forEach { attachment in
                guard let id = attachment.attachmentId else { return }
                performDownloadForLink(id: id, patternId: patternId, filename: attachment.filename)
            }
        }
    }

    private func performDownloadForLink(id: Int, patternId: Int, filename: String?) {
        NetworkHandler.requestDownloadLinkById(id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching download link: \(error)")
                    self?.handleDownloadError(error: error, patternId: patternId)
                default: return
                }
            }, receiveValue: { [weak self] link in
                self?.downloadLink.append(DownloadLink(link, patternID: patternId, filename: filename))
                self?.isPresentingDownload = true
            })
            .store(in: &cancellables)
    }

    private func handleDownloadError(error: Error, patternId: Int) {
        guard let apiError = error as? ApiError else { return }
        if apiError == ApiError.badToken || apiError == ApiError.noToken || apiError == ApiError.invalidResponse {
            networkHandler.requestLibraryToken() { [weak self] success in
                if success {
                    self?.retrieveDownloadLinkNoReauth(patternId: patternId)
                } else {
                    print(error)
                }
            }
        }
    }
    
    private func retrieveDownloadLinkNoReauth(patternId: Int?) {
        if let patternId, let attachments = libraryVolumeFull?.attachments {
            attachments.forEach { attachment in
                guard let id = attachment.attachmentId else { return }
                NetworkHandler.requestDownloadLinkById(id)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            print("Error fetching download link: \(error)")
                        default: return
                        }
                    }, receiveValue: { [weak self] link in
                        self?.downloadLink.append(DownloadLink(link, patternID: patternId, filename: attachment.filename))
                        self?.isPresentingDownload = true
                    })
                    .store(in: &cancellables)
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
