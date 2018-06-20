//
//  OfflineModalController.swift
//  TicTacToe
//
//  Created by SUP'Internet 14 on 30/01/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import UIKit

class OfflineModalController: UIViewController {
    var board :Board!
    var originalPlayerTurn :Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("offline modal loaded")
        setButtonsBorder()
        self.board = Board()
    }
    
    func setButtonsBorder(){
        for i in 1...9{
            let button = self.view.viewWithTag(i) as? UIButton
            button?.layer.borderColor = UIColor.black.cgColor
            button?.layer.borderWidth = 2
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonTouch(_ sender: Any) {
        let buttonTouched = (sender as! UIButton)
        if (self.board.playInBox(boxNumber: buttonTouched.tag)){
            var currentPlayerPicture = UIImage(named: "picturePlayer" + String(self.getCurrentPlayerId())+".png")
            switch self.getCurrentPlayerId() {
            case 0:
                currentPlayerPicture = UIImage(named: "picturePlayer0.png")
            case 1:
                currentPlayerPicture = UIImage(named: "picturePlayer1.png")
            default:
                print("currentPlayerId unexpected")
            }
            buttonTouched.setImage(currentPlayerPicture, for: .normal)
            if (self.board.getWinner() != -1){
                print ("winner is player " + String(self.board.getWinner()))
            }
            self.originalPlayerTurn = !self.originalPlayerTurn
        }
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    private func getCurrentPlayerId() -> Int{
        return Int(NSNumber(value:originalPlayerTurn))
    }
}
