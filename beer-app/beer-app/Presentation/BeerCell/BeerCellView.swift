//
//  CellView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI
import Kingfisher

struct BeerCellView: View {
    
    let beer: Beer
    let imageWidth:CGFloat = 50
    
    var favorite: Bool
    
    var body: some View {
        
        HStack {
            if let beerUrl = URL(string: beer.imageUrl) {
                KFImage.url(beerUrl)
                    .placeholder({
                        Image(systemName: "photo.fill")
                    })
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: Constants.beerCellHeight)
                    .padding(.horizontal, Constants.paddingMedium)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: Constants.beerCellHeight)
                    .padding(.horizontal, Constants.paddingMedium)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(beer.name)
                    if favorite {
                        Text("⭐️")
                    }
                }
                .font(.headline)
                
                Text(beer.description)
                    .font(.subheadline)
                    .lineLimit(3)
            }
            .padding(.vertical, 10)
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).stroke().fill(.gray.opacity(0.2)))
        .background(.ultraThickMaterial)
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: 0.5)
    }
    
}

#Preview {
    BeerCellView(beer: Beer.mock, favorite: false)
}
