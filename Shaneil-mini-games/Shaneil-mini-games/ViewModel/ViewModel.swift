//
//  ViewModel.swift
//  Shaneil-mini-games
//
//  Created by Bronson van den Broeck on 2023/03/03.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var photoData: [Model] = []

    @Published var displayPhotoData: [Model]?
    @Published var score: Int = 0

    init(){
        photoData = [
            Model(image: "peurgot", question: "Logo: Peugoet?", answer: true),
            Model(image: "timberland", question: "Logo: Greencross?", answer: false),
            Model(image: "tinder", question: "Logo: Vodacom?", answer: false),
            Model(image: "vodacom", question: "Logo: Cell C?", answer: false),
            Model(image: "wiki", question: "Logo: Woolworths?", answer: false),
        ]
        displayPhotoData = photoData
    }
    func getIndex(model: Model) -> Int{
        let index = displayPhotoData?.firstIndex(where: {currentModel in
            return model.id == currentModel.id
        }) ?? 0
        return index
    }
}
