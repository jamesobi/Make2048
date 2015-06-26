//
//  Grid.swift
//  Make2048
//
//  Created by James Sobieski on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Grid: CCNodeColor{
    
    let numberOfSquares = 4
    var tiles = [[Tile]]()
    var backgroundTiles = [[Tile]]()
    
    
    let TILEWIDTH:Double = 70.0
    let TILEHEIGHT:Double = 70.0
    
    
    func didLoadFromCCB(){
        
        initializeArray()
        loadBackground()
        //spawnTileAtLocation(3, col: 0)
        spawnStartTiles()
        setupGestures()
        
        
    }
    
    func initializeArray() {
        for r in 0...(numberOfSquares - 1) {
            var innerArray = [Tile]()
            for c in 0...(numberOfSquares - 1) {
                var temporaryTile:Tile = CCBReader.load("Tile") as! Tile
                innerArray.append(temporaryTile)
            }
            tiles.append(innerArray)
        }
    }
    
    
    
    func loadBackground() {
        var rMargin:Double = 0.0
        var cMargin:Double = 0.0
        for r in 0...(numberOfSquares - 1) {
            var innerArray = [Tile]()
            for c in 0...(numberOfSquares - 1) {
                var temporaryTile = CCBReader.load("Tile") as! Tile
                if (r != numberOfSquares - 1) {
                    rMargin = 4.0
                }
                if (c != numberOfSquares - 1) {
                    cMargin = 4.0
                }
                
                temporaryTile.position = ccp(CGFloat(Double(c) * (TILEWIDTH + cMargin) ), CGFloat(Double(r) * (TILEHEIGHT + rMargin)))
                
                temporaryTile.position = ccp(temporaryTile.position.x + 4, temporaryTile.position.y + 4)
                //temporaryTile.valueLabel.string = "\(Int((Double(r) * 4.0) + Double(c)))"
                
                temporaryTile.backgroundColorNode.color = CCColor.grayColor()
                
                addChild(temporaryTile)
                innerArray.append(temporaryTile)
                println("-----")
                println("\(temporaryTile.valueLabel.string)")
                println("The Tile's X is: \(temporaryTile.position.x) and its Y is: \(temporaryTile.position.y)")
                println("-----")
            }
            backgroundTiles.append(innerArray)
        }
    }
    
    
    
    func spawnStartTiles() {
        var numberOfTilesToSpawn = Int(arc4random_uniform(2)) + 2
        for i in 0...numberOfTilesToSpawn {
            spawnRandomTile()
        }
    }
    
    func spawnRandomTile() {
        var randomRow:Int = Int(arc4random_uniform(4))
        var randomCol:Int = Int(arc4random_uniform(4))
        
        if tiles[randomRow][randomCol].valueLabel.string.toInt() < 0 {
            spawnRandomTile()
        }
        spawnTileAtLocation(randomRow, col: randomCol)
    }
    
    func spawnTileAtLocation(row:Int, col:Int) {
        var temporaryTile = CCBReader.load("Tile") as! Tile
        temporaryTile.valueLabel.string = "100"
        temporaryTile.position = backgroundTiles[row][col].position
        temporaryTile.value = .Two
        tiles[row][col] = temporaryTile
        addChild(temporaryTile)
        println("-----")
        println("Tile spawned at : (\(temporaryTile.position.x), \(temporaryTile.position.y))")
    }
    
    func setupGestures() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        swipeLeft.direction = .Left
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight")
        swipeRight.direction = .Right
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeRight)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        swipeUp.direction = .Up
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown")
        swipeDown.direction = .Down
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeDown)
    }
    
    func swipeUp() {
        println("Swipe Up called")
    }
    
    func swipeDown() {
        println("Swipe Down called")
    }
    
    func swipeLeft() {
        println("Swipe Left called")
    }
    
    func swipeRight() {
        moveRight()
        println("Swipe Right called")
    }
    
    func isValidSquare(row:Int, col:Int) -> Bool {
        var done:Bool = true
        if row > (numberOfSquares - 1) || row < 0 {
            done = false
        }
        
        if col > (numberOfSquares - 1) || col < 0 {
            done = false
        }
        return done
    }
    
    func movePiece(firstRow fRow:Int, firstCol fCol:Int, secondRow sRow:Int, secondCol sCol:Int) {
        if isValidSquare(sRow, col: sCol) {
            if tiles[fRow][fCol].value == tiles[sRow][sCol].value {
                switch tiles[fRow][fCol].value {
                case .Two:
                    tiles[sRow][sCol].value = .Four
                    
                case .Four:
                    tiles[sRow][sCol].value = .Eight
                    
                case .Eight:
                    tiles[sRow][sCol].value = .Sixteen
                    
                case .Sixteen:
                    tiles[sRow][sCol].value = .ThirtyTwo
                    
                case .ThirtyTwo:
                    tiles[sRow][sCol].value = .SixtyFour
                    
                case .SixtyFour:
                    tiles[sRow][sCol].value = .OneTwentyEight
                    
                case .OneTwentyEight:
                    tiles[sRow][sCol].value = .TwoFiftySix
                    
                case .TwoFiftySix:
                    tiles[sRow][sCol].value = .FiveTwelve
                    
                case .FiveTwelve:
                    tiles[sRow][sCol].value = .OneThousandTwentyFour
                    
                case .OneThousandTwentyFour:
                    tiles[sRow][sCol].value = .TwentyFortyEight
                    
                default:
                    tiles[sRow][sCol].value = .Four
                }
                
            } else if tiles[fRow][fCol].valueLabel.string.toInt() > 0 && tiles[sRow][sCol].valueLabel.string.toInt() > 0 {
                return
            }else {
                tiles[sRow][sCol].value = tiles[fRow][fCol].value
                tiles[fRow][fCol].value = .None
            }
        }
    }
    
    func moveRight() {
        for var r = 0; r < tiles.count; r += 1 {
            for var c = 0; c < tiles[0].count; c += 1 {
                if(tiles[r][c].valueLabel.string.toInt() > 0){
                    println("moving piece")
                    movePiece(firstRow: r, firstCol: c, secondRow: r, secondCol: c + 1)
                }
                
            }
        }
    }
    func moveLeft() {
        for var r = tiles.count; r > 0; r -= 1 {
            for var c = 0; c < tiles[0].count; c += 1 {
                movePiece(firstRow: r, firstCol: c, secondRow: r, secondCol: c - 1)
                
            }
        }
    }
    func moveUp() {
        for var r = 0; r < tiles.count; r += 1 {
            for var c = 0; c < tiles[0].count; c += 1 {
                movePiece(firstRow: r, firstCol: c, secondRow: r + 1, secondCol: c)
                
            }
        }
    }
    func moveDown() {
        for var r = 0; r < tiles.count; r += 1 {
            for var c = 0; c < tiles[0].count; c += 1 {
                movePiece(firstRow: r, firstCol: c, secondRow: r - 1, secondCol: c)
                
            }
        }
    }
    
    
    
}