//
//  gamePlayViewController.swift
//  ticTacToe
//
//  Created by Marlena Hansen on 4/9/15.
//  Copyright (c) 2015 University of Cincinnati. All rights reserved.
//

import UIKit


class gamePlayViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    
    struct grid {
        //determines size of grid
        static var gridRows:Int = 3;
        static var gridColumns:Int = 3;
        
        //holds data on the grid
        static var gameGrid = [[Int]](count: gridColumns, repeatedValue:[Int](count: gridRows, repeatedValue: 0))
        
        //holds image data
        static var imageCounter = 0
        static var images : [UIImageView] = []
        
        //holds button data
        static var buttonCounter = 0
        static var buttons: [UIButton] = []
    }

    
    //determines if player starts as X or O
    var playerType:Bool = settingsViewController.playerInfo.playerType
    
    //counter determines to input x or o
    var counter = 0
    
    //if X, counter starts as 1, if O, counter starts as 0
    func checkPlayerType(){
        if(playerType){
            counter = counter + 1
            settingsViewController.playerInfo.playerType = true
        } else {
            counter = 0
            settingsViewController.playerInfo.playerType = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //determines player and empties grid
        checkPlayerType()
        emptyGameGrid()
        
        //label to display whos turn
        if(counter % 2 == 0){
            playerLabel.text = "Player O's turn"
        } else {
            playerLabel.text = "Player X's turn"
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //checks the box the user clicked
    @IBAction func checkBox(sender: UIButton){
        
        //getting label number for array
        let label:String = sender.titleLabel!.text!
        
        var fullID = split(label){$0 == " "}
        var id = fullID[0]
        var row = fullID[1]
        
        let idNum:Int = id.toInt()!
        let rowNum:Int = row.toInt()!

        //getting coordinates for picture insertion
        var xValue = sender.frame.origin.x
        var yValue = sender.frame.origin.y
        
        //disabling button clicked
        sender.enabled = false
        
        //sending the button data to the array
        buttonData(grid.buttons, buttonCounter: grid.buttonCounter, button: sender)
 
        //inserts image on top of the box clicked
        updateBox(xValue, yValue: yValue, counter: counter)
        
        //creates the gridarray
        createArray(idNum, rowNum: rowNum, counter: counter)

        
        //updates the counter each turn. Determines x or o
        counter = counter + 1
        
        //label to display whos turn
        if(counter % 2 == 0){
            playerLabel.text = "Player O's turn"
        } else {
            playerLabel.text = "Player X's turn"
        }
    }
    
    
    //posts an image 
    func updateBox(xValue: CGFloat, yValue: CGFloat, counter: Int){
        if(counter%2 == 0){

            var imageName = "o.png"
            var image = UIImage(named: imageName)
            var imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: xValue, y: yValue, width: 85, height: 85)
            view.addSubview(imageView)
            
            imageData(grid.images, imageCounter: grid.imageCounter, imageView: imageView)
            
        } else {
            var imageName = "x.png"
            var image = UIImage(named: imageName)
            var imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: xValue, y: yValue, width: 85, height: 85)
            view.addSubview(imageView)
            
            imageData(grid.images, imageCounter: grid.imageCounter, imageView: imageView)
            
        }
    }
    

    //builds the button data array
    func buttonData(buttons: [UIButton], buttonCounter: Int, button: UIButton){
        grid.buttons.append(button)
        grid.buttonCounter++
    }
    
    
    //builds the image data array
    func imageData(images: [UIImageView], imageCounter: Int, imageView: UIImageView ){
        grid.images.append(imageView)
        grid.imageCounter++

    }
    
    

    //apppends array values so that they are 1 for x, 2 are for o
    func createArray(imageID: Int, rowNum: Int, counter: Int){

        //X
        if(counter % 2 == 0){
            grid.gameGrid[rowNum][imageID] = 1

        //O
        } else {
           grid.gameGrid[rowNum][imageID] = 2
            
        }
        
        //checks to see if there was a winner
        checkWinner(grid.gameGrid)
    }
    
    
    //checks horizontal, vertical, and diagonal arrays for wins
    func checkWinner(gameGrid:[[Int]]){
        
        var winnerCounter : Int
        
        //horizontal
        for var i = 0; i < grid.gridRows; i++ {
            
            winnerCounter = 0
            
            for var c = 1; c < grid.gridColumns; c++ {
                
                if((grid.gameGrid[i][0] == grid.gameGrid[i][c])
                    && grid.gameGrid[i][0] != 0
                    && grid.gameGrid[i][c] != 0)
                {
                    winnerCounter++
                    
                    if(winnerCounter == (grid.gridRows - 1)) {
                        alertWin()
                        i = grid.gridRows
                    }
                }
            }
        }
        
        
        //vertical
        for var i = 0; i < grid.gridColumns; i++ {
            
            winnerCounter = 0
            
            for var c = 1; c < grid.gridRows; c++ {
                
                if((grid.gameGrid[0][i] == grid.gameGrid[c][i])
                    && grid.gameGrid[0][i] != 0
                    && grid.gameGrid[c][i] != 0)
                {
                    winnerCounter++
                    
                    if(winnerCounter == (grid.gridRows - 1)) {
                        alertWin()
                        i = grid.gridRows
                    }
                }
                
            }
            
        }
        
        
        //diagonal
        winnerCounter = 0
        for var c = 1; c < grid.gridRows; c++ {
            
            if((grid.gameGrid[0][0] == grid.gameGrid[c][c])
                && grid.gameGrid[0][0] != 0
                && grid.gameGrid[c][c] != 0)
            {
                winnerCounter++
                if(winnerCounter == (grid.gridRows - 1)) {
                    alertWin()
                    c = grid.gridRows
                }
            }
            
        }
        
        
        //backwards diagonal
        winnerCounter = 0
        for var c = 2; c <= grid.gridRows; c++ {
            
            if((grid.gameGrid[grid.gridRows - 1][0] == grid.gameGrid[grid.gridRows - c][c - 1])
                && grid.gameGrid[grid.gridRows - 1][0] != 0
                && grid.gameGrid[grid.gridRows - c][c - 1] != 0)
            {
                winnerCounter++
                
                if(winnerCounter == (grid.gridRows - 1)) {
                    alertWin()
                    c = grid.gridRows
                }
            }
            
        }

    }
    

    //empties the grid
    func emptyGameGrid() {
        grid.gameGrid = [[Int]](count: grid.gridColumns, repeatedValue:[Int](count: grid.gridRows, repeatedValue: 0))
    }



    //reset the board
    func resetBoard(){
        
        emptyGameGrid()
        
        for var i = 0; i < grid.imageCounter; i++ {
            grid.images[i].removeFromSuperview()
        }
        
        for var i = 0; i < grid.buttonCounter; i++ {
            grid.buttons[i].enabled = true
        }
        
        //update score
        
        if(counter % 2 == 0){
            historyViewController.playerStats.xwinsNum = historyViewController.playerStats.xwinsNum + 1
            historyViewController.playerStats.olosesNum = historyViewController.playerStats.olosesNum + 1
        } else {
            historyViewController.playerStats.owinsNum = historyViewController.playerStats.owinsNum + 1
            historyViewController.playerStats.xlosesNum = historyViewController.playerStats.xlosesNum + 1
        }
        
        
        
    }
    
    
        
    //pop up box for winner
    func alertWin(){
        var playerWin : String
        
        if(counter % 2 == 0){
            playerWin = "Player O"
        } else {
            playerWin = "Player X"
        }
        
        var showWin = UIAlertController(title: "Winner", message: "\(playerWin) wins!", preferredStyle: UIAlertControllerStyle.Alert)
        showWin.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(showWin, animated: true, completion: resetBoard)
        
    }
    
}
