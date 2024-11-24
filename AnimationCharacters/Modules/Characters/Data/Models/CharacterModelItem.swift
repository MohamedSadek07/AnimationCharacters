//
//  CharacterModelItem.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

struct CharacterModelItem {
    var id: Int
    var image: String
    var name : String
    var specie: String
    var gender: String
    var location: String
    var status: String

    init(id: Int = 0,
        image: String = "",
         name: String = "",
         specie: String = "",
         gender: String = "",
         location: String = "",
         status: String = "") {
        self.id = id
        self.image = image
        self.name = name
        self.specie = specie
        self.gender = gender
        self.location = location
        self.status = status
    }
}
