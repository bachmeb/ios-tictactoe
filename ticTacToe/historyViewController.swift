//
//  historyViewController.swift
//  ticTacToe
//
//  Created by Marlena Hansen on 4/9/15.
//  Copyright (c) 2015 University of Cincinnati. All rights reserved.
//

import UIKit

class historyViewController: UIViewController {

    @IBOutlet weak var xwins: UILabel!
    @IBOutlet weak var xloses: UILabel!
    @IBOutlet weak var owins: UILabel!
    @IBOutlet weak var oloses: UILabel!
    
    
    struct playerStats{
        static var xwinsNum : Int = 0
        static var xlosesNum : Int = 0
        static var owinsNum : Int = 0
        static var olosesNum : Int = 0
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xwins.text = String(playerStats.xwinsNum)
        xloses.text = String(playerStats.xlosesNum)
        
        owins.text = String(playerStats.owinsNum)
        oloses.text = String(playerStats.olosesNum)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
