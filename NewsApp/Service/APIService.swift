//
//  APIService.swift
//  NewsApp
//
//  Created by Naela Fauzul Muna on 14/02/24.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchNews() async throws -> [NewsArticle] {
        let url = Constant.newsUrl
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let news = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    continuation.resume(returning: newsResponse.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        return news
    }
}
