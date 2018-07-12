//
//  AlertHelper.swift
//  TicTacToe
//
//  Created by SUP'Internet 06 on 12/07/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import Foundation
import CDAlertView

class AlertHelper {
    
    static func displaySimpleAlert(title: String, message: String, type: CDAlertViewType?){
        let alert = CDAlertView(title: title, message: message, type: type)
        
        alert.add(action: CDAlertViewAction(title: "ok", handler: nil))
        
        alert.show()
    }
}

