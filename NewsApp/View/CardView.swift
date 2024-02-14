//
//  CardView.swift
//  NewsApp
//
//  Created by Naela Fauzul Muna on 14/02/24.
//

import SwiftUI

struct CardView: View {
    var article: NewsArticle
    
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = isoFormatter.date(from: article.isoDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            dateFormatter.locale = Locale(identifier: "id_ID")
            
            return dateFormatter.string(from: date)
        }
        
        return "N/A"
    }

    
    var body: some View {
        let url = URL(string: article.image.small)
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                VStack(alignment: .leading) {
                    HStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text((formattedDate))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top, 4)
                            
                            Text(article.title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .foregroundColor(.black)
                                .padding(.bottom, 15)
                            
                            HStack {
                                Text(article.creator)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .foregroundStyle(.blue)
                                
                                Spacer()
                                
                                HStack {
                                    ForEach(article.categories, id: \.self) { category in
                                        Text(category)
                                            .font(.footnote)
                                            .padding(5)
                                            .background(Color.yellow)
                                            .foregroundColor(.white)
                                            .cornerRadius(5)
                                    }
                                }
                            }
                            
                        }
                    }
                }
                
            case .failure(_):
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "photo.fill")
                            .frame(width: 100, height: 100)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text((formattedDate))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top, 4)
                            
                            Text(article.title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .foregroundColor(.black)
                                .padding(.bottom, 15)
                            
                            HStack {
                                Text(article.creator)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .foregroundStyle(.blue)

                                Spacer()
                                
                                HStack {
                                    ForEach(article.categories, id: \.self) { category in
                                        Text(category)
                                            .font(.footnote)
                                            .padding(5)
                                            .background(Color.yellow)
                                            .foregroundColor(.white)
                                            .cornerRadius(5)
                                    }
                                }
                            }
                            
                        }
                    }
                }
                

            @unknown default:
                fatalError()
            }

        }
    }

}

#Preview {
    CardView(article: NewsArticle(creator: "John Doe", title: "Sample News", link: "https://example.com", categories: ["Technology"], isoDate: "2024-02-14", description: "This is a sample news article.", image: NewsImage(small: "https://internasional.republika.co.id/berita/s8utln366/spanyol-dan-irlandia-minta-komisi-eropa-selidiki-kepatuhan-ham-israel-di-gaza")))
        .previewLayout(.sizeThatFits)
}
