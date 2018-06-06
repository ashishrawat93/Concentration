//
//  Card.swift
//  Concentration
//
//  Created by Ashish Rawat on 6/4/18.
//  Copyright © 2018 Brown University. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {return identifier}

    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    static func ==(lhs:Card, rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
