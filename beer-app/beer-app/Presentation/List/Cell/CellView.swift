//
//  CellView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct CellView: View {
    
    let name: String
    let url: URL
    
    var body: some View {
        HStack {
            AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Image(systemName: "photo.fill")
                    }
                    .frame(width: 50, height: 80)
                    .padding(20)
            VStack {
                Text(name)
                    .font(.headline)
                Spacer()
            }
            .padding(.vertical)
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 20).stroke().fill(.gray.opacity(0.2)))
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 0.5)
        
    }
}

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CellView(name: "Beer", url: URL(string: "https://picsum.photos/200/300")!)
    }
}
