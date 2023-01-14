//
//  ListViewModel.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import Foundation

protocol ViewModel {
    var numberOfRows: Int { get }
    func item(at index: Int) -> String?
}

struct ListViewModel {

    let model = [
        "There is evidence of microbial life on several moons in our solar system.",
        "The conditions necessary for life may be common throughout the universe.",
        "There have been several reported sightings of UFOs.",
        "Scientists have been searching for extraterrestrial life for decades.",
        "The possibility of extraterrestrial life raises questions about the nature of life itself.",
        "The discovery of microbial life on Mars would be a major scientific breakthrough.",
        "The building blocks of life may have been delivered to Earth by comets and meteorites.",
        "Popular culture often explores the possibility of alien life and their interactions with humans.",
        "Extraterrestrial life may take many forms, including microbial, plant-like, and intelligent.",
        "The search for extraterrestrial life is about understanding the origins and evolution of life in the universe.",
        "Many people are fascinated by the possibility of extraterrestrial life.",
        "The discovery of microbial life on other planets or moons would have major implications for our understanding of the universe.",
        "There are many theories about how extraterrestrial life might communicate.",
        "Scientists are using a variety of methods and technologies to search for extraterrestrial life.",
        "The discovery of extraterrestrial life, whether microbial or intelligent, would have major implications for our understanding of the universe.",
        "The conditions necessary for life to emerge may be more common than previously thought.",
        "The search for extraterrestrial life is about understanding the origins and evolution of life in the universe and the potential for life to exist in different conditions.",
        "The possibility of extraterrestrial life raises questions about the nature of life itself and the potential for it to evolve in different environments.",
        "The discovery of microbial life on other planets or moons would provide evidence that life may have evolved independently in different parts of the universe."
    ]

}

extension ListViewModel: ViewModel {

    var numberOfRows: Int {
        model.count
    }

    func item(at index: Int) -> String? {
        guard 0...model.count ~= index else { return nil }
        return model[index]
    }
}
