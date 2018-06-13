//
//  File.swift
//  TicTacToe
//
//  Created by SUP'Internet 09 on 13/06/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import Foundation

class Board {
    private var boxes: [Int] = [-1, -1, -1,
                        -1, -1, -1,
                        -1, -1, -1]
    private var originalPlayerTurn: Bool = true
    private var victoriousPlayerId: Int = -1
    
    func playInBox(boxNumber :Int) -> Bool{
        if (self.boxes[boxNumber - 1] != -1){
            return false
        }
        self.boxes[boxNumber - 1] = self.getCurrentPlayerId()
        self.setVictoriousPlayerId()
        self.originalPlayerTurn = !self.originalPlayerTurn//we change the current player turn
        return true
    }
    
    func getWinner() -> Int{
        return self.victoriousPlayerId
    }
    
    private func setVictoriousPlayerId(){
        let currentPlayerId = self.getCurrentPlayerId()
        if (
            (boxes[0] == currentPlayerId && boxes[1] == currentPlayerId && boxes[2] == currentPlayerId) ||
            (boxes[3] == currentPlayerId && boxes[4] == currentPlayerId && boxes[5] == currentPlayerId) ||
            (boxes[6] == currentPlayerId && boxes[7] == currentPlayerId && boxes[8] == currentPlayerId) ||
            (boxes[0] == currentPlayerId && boxes[3] == currentPlayerId && boxes[6] == currentPlayerId) ||
            (boxes[1] == currentPlayerId && boxes[4] == currentPlayerId && boxes[7] == currentPlayerId) ||
            (boxes[2] == currentPlayerId && boxes[5] == currentPlayerId && boxes[8] == currentPlayerId) ||
            (boxes[0] == currentPlayerId && boxes[4] == currentPlayerId && boxes[8] == currentPlayerId) ||
            (boxes[2] == currentPlayerId && boxes[4] == currentPlayerId && boxes[8] == currentPlayerId)
            ){
            self.victoriousPlayerId = currentPlayerId
        }
    }
    
    private func getCurrentPlayerId() -> Int{
        return Int(NSNumber(value:self.originalPlayerTurn))
    }
}
