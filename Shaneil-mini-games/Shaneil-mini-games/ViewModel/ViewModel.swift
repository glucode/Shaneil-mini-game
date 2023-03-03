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

    init(){
        photoData = [
            Model(image: "back1", question: "question 1", answer: false),
            Model(image: "back2", question: "question 2", answer: false),
            Model(image: "back4", question: "question 3", answer: false),
            Model(image: "back5", question: "question 4", answer: false),
            Model(image: "backgroundPlace", question: "question 5", answer: false),
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
