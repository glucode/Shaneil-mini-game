//
//  Model.swift
//  Shaneil-mini-games
//
//  Created by Bronson van den Broeck on 2023/03/03.
//

import SwiftUI

struct Model: Identifiable {
    var id = UUID().uuidString
    var image: String
    var question: String
    var answer: Bool
}
