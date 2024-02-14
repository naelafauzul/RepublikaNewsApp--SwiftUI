//
//  HorizontalCardView.swift
//  NewsApp
//
//  Created by Naela Fauzul Muna on 15/02/24.
//

import SwiftUI

struct HorizontalCardView: View {
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
                    ZStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading){
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text((formattedDate))
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                
                                Text(article.title)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 15)
                                    .padding(.horizontal, 20)
                            }
                            .frame(width: 300, height: 100)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    }
                }
                .frame(width: 300, height: 200)
                
                
            case .failure(_):
                VStack(alignment: .leading) {
                    ZStack {
                        Image(systemName: "photo.fill")
                            .frame(width: 300, height: 200)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading){
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text((formattedDate))
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                
                                Text(article.title)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 15)
                                    .padding(.horizontal, 20)
                            }
                            .frame(width: 300, height: 100)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }   
                    }
                }
                .frame(width: 300, height: 200)
                
                
            @unknown default:
                fatalError()
            }
            
        }
    }
    
}

#Preview {
    HorizontalCardView(article: NewsArticle(creator: "John Doe", title: "Sample News", link: "https://example.com", categories: ["Technology"], isoDate: "2024-02-14", description: "This is a sample news article.", image: NewsImage(small: "https://internasional.republika.co.id/berita/s8utln366/spanyol-dan-irlandia-minta-komisi-eropa-selidiki-kepatuhan-ham-israel-di-gaza")))
        .previewLayout(.sizeThatFits)
}
