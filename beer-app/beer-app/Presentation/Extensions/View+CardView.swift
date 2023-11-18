//
//  View+CardView.swift
//  beer-app
//
//  Created by Privat on 18.11.23.
//

import SwiftUI

extension View {
    
    func cardView() -> some View {
        
        self
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke()
                .fill(.gray.opacity(0.2)))
            .background(.ultraThickMaterial)
            .cornerRadius(Constants.cornerRadius)
            .shadow(radius: 0.5)
    }
    
}
