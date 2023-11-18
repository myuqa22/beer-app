//
//  DetailView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI
import Kingfisher

struct BeerDetailView: View {
    
    @EnvironmentObject var router: Router
    
    let beer: Beer
    
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
            .padding(.top, Constants.customBackButtonTopPadding)
            .zIndex(Double.infinity)
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.stackSpacing) {
                        HStack {
                            Spacer()
                            KFImage.url(URL(string: beer.imageUrl)!)
                                .placeholder({
                                    Image(systemName: "photo.fill")
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
                        
                        Text(beer.name)
                            .font(.largeTitle)
                            .padding([.horizontal, .top])
                        Text("First brewed at \(beer.firstBrewed)")
                            .font(.subheadline)
                            .padding([.horizontal])
                        
                        VStack(alignment: .leading) {
                            Text("About")
                                .font(.headline)
                                .padding(.horizontal)
                            Text(beer.description)
                                .padding(.horizontal)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Food pairing")
                                .font(.headline)
                                .padding(.horizontal)
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
                            .padding([.horizontal, .bottom])
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    .padding(.vertical)
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
}

#Preview {
    NavigationStack {
        BeerDetailView(beer: Beer.mock)
    }
}
