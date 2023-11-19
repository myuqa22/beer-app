//
//  DetailView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

import Defaults
import Kingfisher

struct BeerDetailView: View {
    
    @EnvironmentObject var router: Router
    
    @Default(.favoritedBeer) var favoritedBeer
    
    let beer: Beer
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            backButton
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.stackSpacing) {
                        ZStack(alignment: .topTrailing) {
                            imageHeader
                            bigFavoriteButton
                        }
                        beerContent
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
        .cardView()
        .padding(Constants.paddingMedium)
    }
    
    var backButton: some View {
        
        Button {
            router.path.remove(at: router.path.count - 1)
        } label: {
            Image(systemName: "chevron.left")
                .tint(.black)
                .padding(Constants.paddingSmall)
                .background(.ultraThickMaterial)
                .clipShape(Circle())
        }
        .padding()
        .zIndex(Double.infinity)
        .accessibilityLabel(Text("Back button"))
    }
    
    var imageHeader: some View {
        
        HStack {
            Spacer()
            if let imageUrl = URL(string: beer.imageUrl) {
                KFImage.url(imageUrl)
                    .placeholder({
                        ProgressView()
                    })
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.detailImageHeight)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.detailImageHeight)
                    .padding(.horizontal, Constants.paddingMedium)
                    .accessibilityLabel(Text("Beer placeholder image"))
            }
            Spacer()
        }
        .padding(.top)
    }
    
    var bigFavoriteButton: some View {
        
        Button {
            if favoritedBeer.contains(beer.id) {
                favoritedBeer.remove(beer.id)
            } else {
                favoritedBeer.insert(beer.id)
            }
        } label: {
            let isFavorite = favoritedBeer.contains(beer.id)
            Image(systemName: isFavorite ? "star.fill" : "star.slash")
                .resizable()
                .frame(width: Constants.iconSizeBig, height: Constants.iconSizeBig)
                .tint(isFavorite ? .yellow : .black)
        }
        .accessibilityLabel(Text(favoritedBeer.contains(beer.id)
                                 ? "Favorite beer" : "Defavorite Beer"))
        .padding()
    }
    
    var beerContent: some View {
        
        VStack(alignment: .leading, spacing: Constants.stackSpacing) {
            Text(beer.name)
                .font(.largeTitle)
                .padding(.horizontal, Constants.paddingMedium)
            Text("First brewed at \(beer.firstBrewed)")
                .font(.subheadline)
                .padding([.horizontal], Constants.paddingMedium)
            
            Text("About")
                .font(.headline)
                .padding(.horizontal, Constants.paddingMedium)
            Text(beer.description)
                .padding(.horizontal, Constants.paddingMedium)
            
            Text("Food pairing")
                .font(.headline)
                .padding(.horizontal, Constants.paddingMedium)
            ScrollView(.horizontal) {
                HStack {
                    Spacer()
                    ForEach(beer.foodPairing, id: \.hashValue) { food in
                        Text(food)
                            .font(.subheadline)
                            .padding(Constants.paddingSmall)
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(Constants.cornerRadius)
                    }
                }
                .scrollIndicators(.hidden)
            }
            Text("Contributed by \(beer.contributedBy)")
                .font(.callout)
                .foregroundColor(.gray)
                .padding([.horizontal, .bottom], Constants.paddingMedium)
        }
        .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    NavigationStack {
        BeerDetailView(beer: Beer.mock)
    }
}
