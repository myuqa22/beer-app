//
//  DetailView.swift
//  beer-app
//
//  Created by Privat on 16.11.23.
//

import SwiftUI

struct DetailView: View {
    
    let beer: Beer
    
    var body: some View {
        HStack {
            
            Text(beer.name)
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        DetailView(beer: Beer.mock)
    }
}
