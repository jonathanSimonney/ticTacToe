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
        self.winnerLabel.isHidden = true
        self.board = Board()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTouch(_ sender: Any) {
        if (!self.board.canContinuePlaying()){
            return;
        }
        
        let buttonTouched = (sender as! UIButton)
        if (self.board.playInBox(boxNumber: buttonTouched.tag)){
            let currentPlayerPicture = UIImage(named: "picturePlayer" + String(self.getCurrentPlayerId())+".png")
            buttonTouched.setImage(currentPlayerPicture, for: .normal)
            if (!self.board.canContinuePlaying()){
                presentWinner()
                self.updateData(winnerPlayerId: self.getCurrentPlayerId())
            }
            self.originalPlayerTurn = !self.originalPlayerTurn
        }
    }
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBAction func closeAction(_ sender: Any) {
        if (!self.board.canContinuePlaying()){
            self.dismiss(animated: false, completion: nil);
        }
        let alert = UIAlertController(title: "Leave?", message: "If you leave, you'll be considered as having lost this game. ", preferredStyle: .alert)
        let modalViewController = self
        
        alert.addAction(UIAlertAction(title: "Leave", style: .default, handler: {
            (alert: UIAlertAction!) in
            modalViewController.updateData(winnerPlayerId: modalViewController.getOppositePlayerId())
            modalViewController.dismiss(animated: false, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Stay", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //helper functions
    private func updateData(winnerPlayerId: Int){
        let cache = NSCache<NSString, AnyObject>()
        var myResults: [Int] = []
        
        if let results = cache.object(forKey: "results") {
            // use the cached version
            myResults = (results as? [Int])!
        }
            // create it from scratch then store in the cache
        myResults.append(winnerPlayerId)
        cache.setObject(myResults as AnyObject, forKey: "results")
    }
    
    private func setButtonsBorder(){
        for i in 1...9{
            let button = self.view.viewWithTag(i) as? UIButton
            button?.layer.borderColor = UIColor.black.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    private func presentWinner(){
        if (self.board.getWinner() != -1){
            self.winnerLabel.text = "player \(String(self.board.getWinner())) won"
            self.colorButtons(arrayTags: self.board.getColoredBoxes())
        }else{
            self.winnerLabel.text = "no player won. Draw!"
        }
        self.winnerLabel.isHidden = false
    }
    
    private func colorButtons(arrayTags: [Int]){
        for i in arrayTags{
            let button = self.view.viewWithTag(i) as? UIButton
            button?.backgroundColor = .red
        }
    }
    
    private func getCurrentPlayerId() -> Int{
        return Int(NSNumber(value:originalPlayerTurn))
    }
    
    private func getOppositePlayerId() -> Int{
        return Int(NSNumber(value:!originalPlayerTurn))
    }
}
