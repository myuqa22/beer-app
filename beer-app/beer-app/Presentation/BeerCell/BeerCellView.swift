//
//  CellView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI
import Kingfisher
import Defaults

struct BeerCellView: View {
    
    @EnvironmentObject var router: Router
    
    @Default(.favoritedBeer) var favoritedBeer
    
    let beer: Beer
    let imageWidth:CGFloat = 50
    
    var body: some View {
        
        HStack {
            if let beerUrl = URL(string: beer.imageUrl) {
                KFImage.url(beerUrl)
                    .placeholder({
                        ProgressView()
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
                    if favoritedBeer.contains(beer.id) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.yellow)
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
        .cardView()
        .swipeActions(edge: .trailing) {
            Button {
                
                if favoritedBeer.contains(beer.id) {
                    favoritedBeer.remove(beer.id)
                } else {
                    favoritedBeer.insert(beer.id)
                }
                
            } label: {
                if favoritedBeer.contains(beer.id) {
                    Text("❌")
                } else {
                    Text("⭐️")
                }
                
            }
            .tint(.clear)
        }
        .onTapGesture {
            router.path.append(.detail(beer))
        }
    }
    
}

#Preview {
    BeerCellView(beer: Beer.mock)
}
