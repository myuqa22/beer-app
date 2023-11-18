//
//  CellView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

import Defaults
import Kingfisher

struct BeerCellView: View {
    
    @EnvironmentObject var router: Router
    
    @Default(.favoritedBeer) var favoritedBeer
    
    let beer: Beer
    
    var body: some View {
        
        HStack {
            teaserImage
            VStack(alignment: .leading) {
                headline
                Text(beer.description)
                    .font(.subheadline)
                    .lineLimit(3)
            }
            .padding(.vertical, Constants.paddingSmall)
            Spacer()
        }
        .cardView()
        .swipeActions(edge: .trailing) {
            swipeActionFavoriteButton
        }
        .onTapGesture {
            router.path.append(.detail(beer))
        }
    }
    
    @ViewBuilder
    var teaserImage: some View {
        
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
                .frame(width: Constants.teaserImageWidth, height: Constants.beerCellHeight)
                .padding(.horizontal, Constants.paddingMedium)
                .accessibilityLabel(Text("Beer image"))
        } else {
            Image(systemName: "photo.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.teaserImageWidth, height: Constants.beerCellHeight)
                .padding(.horizontal, Constants.paddingMedium)
                .accessibilityLabel(Text("Beer placeholder image"))
        }
    }
    
    var headline: some View {
        
        HStack {
            Text(beer.name)
            if favoritedBeer.contains(beer.id) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: Constants.iconSizeMedium, height: Constants.iconSizeMedium)
                    .foregroundColor(.yellow)
                    .accessibilityLabel(Text("Favorite"))
            }
        }
        .font(.headline)
    }
    
    var swipeActionFavoriteButton: some View {
        
        Button {
            if favoritedBeer.contains(beer.id) {
                favoritedBeer.remove(beer.id)
            } else {
                favoritedBeer.insert(beer.id)
            }
        } label: {
            let isFavorite = favoritedBeer.contains(beer.id)
            Image(systemName: isFavorite ? "star.slash" : "star.fill")
                .resizable()
                .frame(width: Constants.iconSizeMedium, height: Constants.iconSizeMedium)
                .tint(isFavorite ? .black : .yellow)
        }
        .tint(.clear)
        .accessibilityLabel(Text(favoritedBeer.contains(beer.id) ? "Defavorite beer" : "Favorite beer"))
    }
    
}

#Preview {
    BeerCellView(beer: Beer.mock)
}
