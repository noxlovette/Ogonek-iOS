//
//  Alias+Deck.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

typealias DeckWithCards = Components.Schemas.DeckWithCards
typealias Deck = Components.Schemas.DeckFull
typealias DeckSmall = Components.Schemas.DeckSmall
// typealias DeckPublic = Components.Schemas.DeckPublic
typealias Card = Components.Schemas.Card
extension Card: Identifiable {}

extension DeckSmall: Identifiable {}
