//
//  CharactersViewModelProtocol.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

protocol CharactersViewModelProtocol {
    func getCharacters()
    func filterCharacters(status: String)
    func resetPaginationAttributes()
    func pushtoDetailsView(characterID: Int)
}
