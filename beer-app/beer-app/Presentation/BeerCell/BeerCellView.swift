//
//  CellView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct BeerCellView: View {
    
    let beer: Beer
    var favorite: Bool
    
    var body: some View {
        HStack {
            if let beerUrl = URL(string: beer.image_url) {
                AsyncImage(url: beerUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "photo.fill")
                        }
                        .frame(width: 50, height: 100)
                        .padding(.horizontal, 20)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .padding(.horizontal, 20)
            }
            
            VStack(alignment: .leading, spacing: 10) {
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
        .background(RoundedRectangle(cornerRadius: 20).stroke().fill(.gray.opacity(0.2)))
        .background(.ultraThickMaterial)
        .cornerRadius(20)
        .shadow(radius: 0.5)
    }
}

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BeerCellView(beer: Beer.mock, favorite: false)
    }
}
