//
//  Alert.swift
//  beer-app
//
//  Created by Privat on 19.11.23.
//

import Foundation

struct AlertMessage: Identifiable {
    
    var id: String { text }
    let text: String
}
