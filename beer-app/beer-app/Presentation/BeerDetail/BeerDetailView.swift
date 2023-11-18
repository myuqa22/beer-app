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
    let favoriteButtonSize: CGFloat = 30
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
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
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.stackSpacing) {
                        ZStack(alignment: .topTrailing) {
                            HStack {
                                Spacer()
                                KFImage.url(URL(string: beer.imageUrl)!)
                                    .placeholder({
                                        ProgressView()
                                    })
                                    .loadDiskFileSynchronously()
                                    .cacheMemoryOnly()
                                    .fade(duration: 0.25)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: Constants.detailImageHeight)
                                Spacer()
                            }
                            .padding(.top)
                            
                            Button {
                                if favoritedBeer.contains(beer.id) {
                                    favoritedBeer.remove(beer.id)
                                } else {
                                    favoritedBeer.insert(beer.id)
                                }
                            } label: {
                                if favoritedBeer.contains(beer.id) {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: favoriteButtonSize, height: favoriteButtonSize)
                                        .tint(.yellow)
                                } else {
                                    Image(systemName: "star.slash")
                                        .resizable()
                                        .frame(width: favoriteButtonSize, height: favoriteButtonSize)
                                    
                                        .tint(.black)
                                }
                            }
                            .accessibilityLabel(Text(favoritedBeer.contains(beer.id) ? "Favorite beer": "Defavorite Beer"))
                            .padding()
                        }
                        
                        Text(beer.name)
                            .font(.largeTitle)
                            .padding(.horizontal, Constants.paddingMedium)
                        Text("First brewed at \(beer.firstBrewed)")
                            .font(.subheadline)
                            .padding([.horizontal], Constants.paddingMedium)
                        
                        VStack(alignment: .leading) {
                            Text("About")
                                .font(.headline)
                                .padding(.horizontal, Constants.paddingMedium)
                            Text(beer.description)
                                .padding(.horizontal, Constants.paddingMedium)
                        }
                        
                        VStack(alignment: .leading) {
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
                            }
                            .scrollIndicators(.hidden)
                        }
                        Spacer()
                        Text("Contributed by \(beer.contributedBy)")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding([.horizontal, .bottom], Constants.paddingMedium)
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
        .cardView()
        .padding(Constants.paddingMedium)
    }
    
}

#Preview {
    NavigationStack {
        BeerDetailView(beer: Beer.mock)
    }
}
