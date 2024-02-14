//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Naela Fauzul Muna on 13/02/24.
//

import Foundation

struct NewsResponse: Decodable {
    var messages: String
    var total: Int
    var data: [NewsArticle]
}

struct NewsArticle: Decodable, Identifiable {
    var id: String { link }
    var creator: String
    var title: String
    var link: String
    var categories: [String]
    var isoDate: String
    var description: String
    var image: NewsImage
}

struct NewsImage: Decodable {
    var small: String
}
