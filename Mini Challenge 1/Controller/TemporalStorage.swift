//
//  TemporalStorage.swift
//  Mini Challenge 1
//
//  Created by Michael Chrisandy on 02/04/24.
//

import SwiftUI

class TemporalStorage{
    static var explainTurn : [Player] = []
    static var commentTurn : [Player] = []
    static var explainTurnNumber = 0
    static var commentTurnNumber = 0
    
    static func shuffleExplainTurn(){
        explainTurn.shuffle()
    }
    
    static func shuffleCommentTurn(){
        commentTurn.shuffle()
    }
    
    static func setPlayers(players : [Player]){
        explainTurn = players
        commentTurn = players
    }
}
