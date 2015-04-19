//
//  gamePlayViewController.swift
//  ticTacToe
//
//  Created by Marlena Hansen on 4/9/15.
//  Copyright (c) 2015 University of Cincinnati. All rights reserved.
//



//To Do:

//1. Make other grids
//4. Finish settings (grid size, computer yes or no)
//6. set variable for height somewhere in the statement
//7. make computer have a delay

import UIKit


class gamePlayViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    
    struct grid {
        //needs to come from settings page
        static var columns : Int = 3
        static var rows : Int = 3
        static var gameGrid = [[Int]](count: rows, repeatedValue:[Int](count: columns, repeatedValue: 0))
        static var pictureSize : Int = 85
        
        //holds image data
        static var imageCounter = 0
        static var images : [UIImageView] = []
    }

    //creates object of gridClass
    let gridCreated = gridClass(rows: grid.rows, columns: grid.columns)
    
    //counter determines to input x or o
    var counter = 0
    var turnCounter : Int = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridCreated.createGrid(self)
        
        //determines if player starts as X or O
        var playerType:Bool = settingsViewController.playerInfo.playerType
        
        checkPlayerType(playerType)
        
        emptyGameGrid()
        
        
        if(counter % 2 == 0){
            playerLabel.text = "Player O's turn"
        } else {
            playerLabel.text = "Player X's turn"
        }
        
        
        //determining size of images
        if(grid.rows == 3){
            
            grid.pictureSize = 85
            
        } else if (grid.rows == 4){
            
            grid.pictureSize = 60
            
        } else if (grid.rows == 5){
            
            grid.pictureSize = 55
            
        } else {
            
            grid.pictureSize = 85
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //if X, counter starts as 1, if O, counter starts as 0
    func checkPlayerType(playerType : Bool){
        if(playerType){
            counter = counter + 1
            settingsViewController.playerInfo.playerType = true
        } else {
            counter = 0
            settingsViewController.playerInfo.playerType = false
        }
    }
    
    //checks the box the user clicked
    @IBAction func checkBox(sender: UIButton){
        
        sender.enabled = false
        view.userInteractionEnabled = false
    
        //gets the button label. Button label = <column> <row>
        let label:String = sender.titleLabel!.text!
        var fullID = split(label){$0 == " "}
        var column = fullID[0]
        var row = fullID[1]
        let columnNum:Int = column.toInt()!
        let rowNum:Int = row.toInt()!

        var xValue = sender.frame.origin.x
        var yValue = sender.frame.origin.y
        
        if(grid.gameGrid[rowNum][columnNum] == 0){
            createArray(columnNum, rowNum: rowNum, counter: counter)
           
            updateBox(xValue, yValue: yValue, counter: counter)
            
            counter++
        
            if(counter % 2 == 0){
                playerLabel.text = "Player O's turn"
            } else {
                playerLabel.text = "Player X's turn"
            }
        
            turnCounter++
        
            var allowance : Int = grid.rows * grid.columns
            var compAllowance = allowance - 1
        
            if ((turnCounter < compAllowance) && (settingsViewController.playerInfo.computerOn == true) && (grid.rows % 2 != 0)){
                
                //disables touch until after computer goes
                view.userInteractionEnabled = false
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: Selector("computerPlay"), userInfo: nil, repeats: false)
            
            } else if ((settingsViewController.playerInfo.computerOn == true) && (grid.rows % 2 == 0)){
                
                //disables touch until after computer goes
                view.userInteractionEnabled = false
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: Selector("computerPlay"), userInfo: nil, repeats: false)
                
            } else {
                println("Error")
            }
            
        } else {
            
            view.userInteractionEnabled = true
            
        }
    }
    
    
    
    
    
    //posts an image 
    func updateBox(xValue: CGFloat, yValue: CGFloat, counter: Int){
        var width : CGFloat = CGFloat(grid.pictureSize)
        var height : CGFloat = CGFloat(grid.pictureSize)
        
        if(counter%2 == 0){

            var imageName = "o.png"
            var image = UIImage(named: imageName)
            var imageView = UIImageView(image: image!)
            

            imageView.frame = CGRect(x: xValue, y: yValue, width: width, height: height)
            view.addSubview(imageView)
            
            imageData(grid.images, imageCounter: grid.imageCounter, imageView: imageView)
            
        } else {
            var imageName = "x.png"
            var image = UIImage(named: imageName)
            var imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: xValue, y: yValue, width: width, height: height)
            view.addSubview(imageView)
            
            imageData(grid.images, imageCounter: grid.imageCounter, imageView: imageView)
            
        }
    }
    

    
    
    //builds the image data array
    func imageData(images: [UIImageView], imageCounter: Int, imageView: UIImageView ){
        grid.images.append(imageView)
        grid.imageCounter++

    }
    
    

    //handles array for X and O & checks winner / loser
    func createArray(imageID: Int, rowNum: Int, counter: Int){

        //X
        if(counter % 2 == 0){
            grid.gameGrid[rowNum][imageID] = 1

        //O
        } else {
           grid.gameGrid[rowNum][imageID] = 2
            
        }
        
        checkWinner(grid.gameGrid)
        checkLose(grid.gameGrid)
    }
    
    
    //checks for win
    func checkWinner(gameGrid:[[Int]]){
        
        var winnerCounter : Int
        
        //horizontal
        for var i = 0; i < gridCreated.gridRows; i++ {
            
            winnerCounter = 0
            
            for var c = 1; c < gridCreated.gridColumns; c++ {
                
                if((grid.gameGrid[i][0] == grid.gameGrid[i][c])
                    && grid.gameGrid[i][0] != 0
                    && grid.gameGrid[i][c] != 0)
                {
                    winnerCounter++
                    
                    if(winnerCounter == (gridCreated.gridRows - 1)) {
                        alertWin()
                        i = gridCreated.gridRows
                    }
                }
            }
        }
        
        
        //vertical
        for var i = 0; i < gridCreated.gridColumns; i++ {
            
            winnerCounter = 0
            
            for var c = 1; c < gridCreated.gridRows; c++ {
                
                if((grid.gameGrid[0][i] == grid.gameGrid[c][i])
                    && grid.gameGrid[0][i] != 0
                    && grid.gameGrid[c][i] != 0)
                {
                    winnerCounter++
                    
                    if(winnerCounter == (gridCreated.gridRows - 1)) {
                        alertWin()
                        i = gridCreated.gridRows
                    }
                }
                
            }
            
        }
        
        
        //diagonal
        winnerCounter = 0
        for var c = 1; c < gridCreated.gridRows; c++ {
            
            if((grid.gameGrid[0][0] == grid.gameGrid[c][c])
                && grid.gameGrid[0][0] != 0
                && grid.gameGrid[c][c] != 0)
            {
                winnerCounter++
                if(winnerCounter == (gridCreated.gridRows - 1)) {
                    alertWin()
                    c = gridCreated.gridRows
                }
            }
            
        }
        
        
        //backwards diagonal
        winnerCounter = 0
        for var c = 2; c <= gridCreated.gridRows; c++ {
            
            if((grid.gameGrid[gridCreated.gridRows - 1][0] == grid.gameGrid[gridCreated.gridRows - c][c - 1])
                && grid.gameGrid[gridCreated.gridRows - 1][0] != 0
                && grid.gameGrid[gridCreated.gridRows - c][c - 1] != 0)
            {
                winnerCounter++
                
                if(winnerCounter == (gridCreated.gridRows - 1)) {
                    alertWin()
                    c = gridCreated.gridRows
                }
            }
            
        }
        view.userInteractionEnabled = true
    }
    
    //checks to see if the board is full
    func checkLose(gameGrid:[[Int]]){
        
        var loserCounter : Int = 0
        
        for var i = 0; i < gridCreated.gridRows; i++ {
            
            for var c = 0; c < gridCreated.gridColumns; c++ {
                
                if(grid.gameGrid[i][c] != 0)
                {
                    loserCounter++
                }
                
                if(loserCounter == (gridCreated.gridRows * gridCreated.gridColumns))
                {
                    var showWin = UIAlertController(title: "Loser", message: "No one wins!", preferredStyle: UIAlertControllerStyle.Alert)
                    showWin.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    presentViewController(showWin, animated: true, completion: resetBoard)
                }
                
            }
        }
        
    }
    

    //empties the grid array
    func emptyGameGrid() {
        grid.gameGrid = [[Int]](count: gridCreated.gridColumns, repeatedValue:[Int](count: gridCreated.gridRows, repeatedValue: 0))
    }



    //reset the board & updates Score
    func resetBoard(){
        
        emptyGameGrid()
        turnCounter = 0
        
        for var i = 0; i < grid.imageCounter; i++ {
            grid.images[i].removeFromSuperview()
        }
        
        gridCreated.createGrid(self)
        
        
        if(counter % 2 == 0){
            historyViewController.playerStats.xwinsNum = historyViewController.playerStats.xwinsNum + 1
            historyViewController.playerStats.olosesNum = historyViewController.playerStats.olosesNum + 1
        } else {
            historyViewController.playerStats.owinsNum = historyViewController.playerStats.owinsNum + 1
            historyViewController.playerStats.xlosesNum = historyViewController.playerStats.xlosesNum + 1
        }
        

        
    }
    
    

    
    
    //functionality for computer to play
    func computerPlay(){
        
        var row  = Int(arc4random_uniform(UInt32(grid.rows)))
        var column = Int(arc4random_uniform(UInt32(grid.columns)))
        
        if(grid.gameGrid[row][column] == 1){

            computerPlay()
            
            
        } else if (grid.gameGrid[row][column] == 2){
            
            computerPlay()
            
        } else {
            
            checkComputerBox(row, column: column)
            turnCounter++
        }
        
        
    }
    
    
    //checks the box the user clicked
    func checkComputerBox(row: Int, column: Int){

        var buttonID = gridCreated.buttons[row][column]
    
        buttonID.enabled = false
        
        var xValue = buttonID.frame.origin.x
        var yValue = buttonID.frame.origin.y
        
        updateBox(xValue, yValue: yValue, counter: counter)
        
        createArray(column, rowNum: row, counter: counter)
        
        counter++
        
        if(counter % 2 == 0){
            playerLabel.text = "Player O's turn"
        } else {
            playerLabel.text = "Player X's turn"
        }
        
        //reenables user touch
        view.userInteractionEnabled = true
        
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
