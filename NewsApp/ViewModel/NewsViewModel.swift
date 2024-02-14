//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Naela Fauzul Muna on 14/02/24.
//

import Foundation
import SwiftUI

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles = [NewsArticle]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadNews() async {
        isLoading = true
        defer { isLoading = false}
        errorMessage = nil
        
        do {
            self.articles = try await APIService.shared.fetchNews()
        } catch {
            errorMessage = "\(error.localizedDescription) Failed to fetch news"
            print(error)
        }
    }
    
    enum LoadingOverlayState {
        case loading
        case error(String)
        case none
    }

    var loadingOverlay: LoadingOverlayState {
        if isLoading {
            return .loading
        } else if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error(errorMessage)
        } else {
            return .none
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Error downloading image: \(error.localizedDescription)")
            return nil
        }
    }

}

