//
//  DetailView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct BeerDetailView: View {
    
    @EnvironmentObject var router: Router
    
    let beer: Beer
    
    var body: some View {

        ZStack(alignment: .topLeading) {
            Button {
                router.path.remove(at: router.path.count - 1)
            } label: {
                Image(systemName: "chevron.left")
                    .tint(.white)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding()
            .zIndex(3)
            Color.gray.opacity(0.1)
            ScrollView {
                    Image("pexel")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 400)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(beer.name)
                            .font(.largeTitle)
                            .padding([.horizontal, .top])
                        Text("First brewed at \(beer.first_brewed)")
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
                                        
                                    ForEach(beer.food_pairing, id: \.hashValue) { food in
                                        Text(food)
                                            .font(.subheadline)
                                            .padding(10)
                                            .background(.black)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                        Spacer()
                        Text("Contributed by \(beer.contributed_by)")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding([.horizontal, .bottom])
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.bottom])
                }
            .navigationBarBackButtonHidden()
            .foregroundStyle(.white)
            .background(.gray)
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            BeerDetailView(beer: Beer.mock)
        }
       
    }
}
