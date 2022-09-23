//
//  ViewController.swift
//  NewThreeInARow
//
//  Created by Pauline Broängen on 2022-09-20.
//

import UIKit

class ViewController: UIViewController {
//below I am making two enum cases, one for O-circle and one for X-cross.
    enum PlayerTurn {
        case Circle
        case Cross
    }
    
    //below is the label that tells whos turn it is and this shifts.
    @IBOutlet weak var lblTurn: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    
    var firstPlayer = PlayerTurn.Cross
    var currentPlayer = PlayerTurn.Cross
    
    //below is the two strings with the players, X and O that will appear on the board when pressed.
    var CROSS = "X"
    var CIRCLE = "O"
    
    //below is the array for all the buttons above in the outlets which is a function.
    var gameBoard = [UIButton]()

    //below is the scores for each player that will appear on a scoreactionsheet/alertmessage.
    var crossScore = 0
    var circleScore = 0


    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //below is a initfunction that is to all the buttons. append means that you give each button a value.
        initGameBoard()
    }
    func initGameBoard() {
        gameBoard.append(btn1)
        gameBoard.append(btn2)
        gameBoard.append(btn3)
        gameBoard.append(btn4)
        gameBoard.append(btn5)
        gameBoard.append(btn6)
        gameBoard.append(btn7)
        gameBoard.append(btn8)
        gameBoard.append(btn9)
    }
    
    
    //below is a boardPressAction, that is an action for when you click on any button. I have connected every nine button to this action. I can see that every button is connected if I hoover over the black connectiondot. if someone wins then the count add one to the score.
        
    @IBAction func boardPressAction(_ sender: UIButton) {
        //below I am connecting the function placeOnBoard to this action function.
        placeOnBoard(sender)
        if checkWinner(CIRCLE) {
            circleScore += 1
            resultAlert(title: "Circle has won!")
        }
        if checkWinner(CROSS) {
            crossScore += 1
            resultAlert(title: "Cross has won")
        }
        if(fullGameBoard()) {
            resultAlert(title: "Nobody won.")
        }
    }
        
        
        
        //below is the function for how to check the winner. it checks if every row has the same letter.
        func checkWinner(_ s :String) -> Bool {
            //horizontal victory first row - left to right, right to left
            if playerLetter(btn1, s) && playerLetter(btn2, s) && playerLetter(btn3, s) {
                return true
            }
            
            //second row
            if playerLetter(btn4, s) && playerLetter(btn5, s) && playerLetter(btn6, s) {
                return true
            }
            
            //third row
            if playerLetter(btn7, s) && playerLetter(btn8, s) && playerLetter(btn9, s) {
                return true
            }
            
            //vertical victory first row - up to down, down to up
            if playerLetter(btn1, s) && playerLetter(btn4, s) && playerLetter(btn7, s) {
                return true
            }
            
            //second row
            if playerLetter(btn2, s) && playerLetter(btn5, s) && playerLetter(btn8, s) {
                return true
            }
            
            //third row
            if playerLetter(btn3, s) && playerLetter(btn6, s) && playerLetter(btn9, s) {
                return true
            }
            
            //diagonal victory - from leftup to rightdown and viceverse and leftdown to rightup...
            if playerLetter(btn1, s) && playerLetter(btn5, s) && playerLetter(btn9, s) {
                return true
            }
            
            if playerLetter(btn7, s) && playerLetter(btn5, s) && playerLetter(btn3, s) {
                return true
            }
            return false
        }
    
    
        
        //below is the function for symbol on the board that is in checkWinnerfunction.
        func playerLetter(_ button: UIButton, _ symbol: String) -> Bool {
            return button.title(for: .normal) == symbol
        }


    
    //below I added av menu or a message and describe how it should look like and the scores are variables.
    func resultAlert(title: String) {
        let resultMessage = "\nCircle " + String(circleScore) + "\nCross " + String(crossScore)
        let resultMenu = UIAlertController(title: title, message: resultMessage, preferredStyle: .alert)
        resultMenu.addAction(UIAlertAction(title: "Reset and start a new game", style: .default, handler: { (_) in self.resetBoard()
        }))
    self.present(resultMenu, animated: true)
    }
 
        
    //below is the resetboard. gameBoard is the variabel at the top. 
        func resetBoard() {
            for button in gameBoard {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if firstPlayer == PlayerTurn.Cross {
                firstPlayer = PlayerTurn.Circle
                lblTurn.text = CIRCLE
            }
            else if firstPlayer == PlayerTurn.Circle {
                firstPlayer = PlayerTurn.Cross
                lblTurn.text = CROSS
            }
            currentPlayer = firstPlayer
        }


    
    
//below is a function to check if the gameBoard is full with letters.
func fullGameBoard() -> Bool {
    for button in gameBoard {
        if button.title(for: .normal) == nil {
            return false
        }
    }
        return true
    }

    
    
    
    
//below is a function for when you press the board and play and continue to play until the board is full. if the button doesn't have a title = nil, you will fill it with a title, either cross och circle.
func placeOnBoard(_ sender: UIButton) {
    if(sender.title(for: .normal) == nil) {
        
        //when the game starts it starts with a cross.
        if(currentPlayer == PlayerTurn.Cross) {
            sender.setTitle(CROSS, for: .normal)
            //below the label switch into the other player, that is the circle.
            currentPlayer = PlayerTurn.Circle
            lblTurn.text = CIRCLE
        }
 
        //then the playersymbol turns a circle.
        else if(currentPlayer == PlayerTurn.Circle) {
            sender.setTitle(CIRCLE, for: .normal)
            //below the label switch into the other player, that is the cross.
            currentPlayer = PlayerTurn.Cross
            lblTurn.text = CROSS
        }
        sender.isEnabled = false
    }
    }
}
