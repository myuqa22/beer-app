//
//  Image+Fit.swift
//  beer-app
//
//  Created by Privat on 18.11.23.
//

import SwiftUI

extension Image {
    
    func imageFit() -> some View {
            self
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .clipShape(Circle())
       }}
