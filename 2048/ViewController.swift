//
//  ViewController.swift
//  2048
//
//  Created by Tung on 6/28/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lose: Bool = false
    @IBOutlet weak var score: UILabel!
    var b = Array(repeating: Array(repeating:0, count:4), count: 4)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions
        {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(responToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
        randomNum(-1)
    }
    func responToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizerDirection.left:
                randomNum(0)
            case UISwipeGestureRecognizerDirection.right:
                randomNum(1)
            case UISwipeGestureRecognizerDirection.up:
                randomNum(2)
            case UISwipeGestureRecognizerDirection.down:
                randomNum(3)
            default:
                break
            }
        }
    }
    //Kiem tra o random con trong
    func checkRandom() -> Bool
    {
        for i in 0 ... 3
        {
            for j in 0 ... 3
            {
                if b[i][j] == 0
                {
                    return true
                }
            }
        }
        return false
    }
    //Kiem tra thua, khi tren luoi ko co 2 o co gia tri bang nhau
    //Kiem tra 1 khoang 3x3 (luoi 4x4)
    func checkLose() -> Bool
    {
        for i in 0 ..< 3
        {
            for j in 0 ..< 3
            {
                if (b[i][j] == b[i+1][j] || b[i][j] == b[i][j+1]) {
                    return false
                }
            }
        }
        //Check cac vi tri bang nhau o bien
        if b[3][0] == b[3][1]
        {
            return false
        }
        if b[3][1] == b[3][2]
        {
            return false
        }
        if b[3][2] == b[3][3]
        {
            return false
        }
        if b[0][3] == b[1][3]
        {
            return false
        }
        if b[1][3] == b[2][3]
        {
            return false
        }
        if b[2][3] == b[3][3]
        {
            return false
        }
        return true
    }
    
    //Di chuyen len, xuong, trai, phai
    func up()
    {
        for col in 0..<4
        {
            var check = false
            for row in 1..<4
            {
                var tx = row
                if(b[row][col] == 0)
                {
                    continue
                }
                //for (var rowc = row - 1; rowc != -1; row--)
                for rowc in (0 ... row-1).reversed()
                {
                    if(b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        tx = rowc
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[row][col] == b[tx][col])
                {
                    check = true
                    b[tx][col] *= 2
                    GetScore(value: b[tx][col])
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0
            }
        }
    }
    
    func down()
    {
        for col in 0 ..< 4
        {
            var check = false
            for row in 0 ..< 4
            {
                var tx = row
                if (b[row][col] == 0)
                {
                    continue
                }
                for rowc in row + 1 ..< 4
                {
                    if (b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        tx = rowc
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[tx][col] == b[row][col])
                {
                    check = true
                    b[tx][col] *= 2
                    GetScore(value: b[tx][col])
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0
            }
        }
    }
    
    
    func left()
    {
        for row in 0 ..< 4
        {
            var check = false
            for col in 1 ..< 4
            {
                if (b[row][col] == 0)
                {
                    continue
                }
                var ty = col
                for colc in ((-1 + 1)...col - 1).reversed()
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    b[row][ty] *= 2
                    GetScore(value: b[row][ty])
                    
                }
                else
                {
                    b[row][ty]=b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    
    func right()
    {
        for row in 0 ..< 4
        {
            var check = false
            for col in ((-1 + 1)...3).reversed()
            {
                if (b[row][col] == 0)
                {
                    continue
                }
                var ty = col
                for colc in col + 1 ..< 4
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    b[row][ty] *= 2
                    GetScore(value: b[row][ty])
                    
                }
                else
                {
                    b[row][ty] = b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    
    func randomNum (_ type : Int)
    {
        if (!self.lose)
        {
            switch type {
            case 0:
                self.left()
            case 1:
                self.right()
            case 2:
                self.up()
            case 3:
                self.down()
            default:
                break
            }
        }
        if checkRandom()
        {
            
            var rnlabelX = arc4random_uniform(4)
            var rnlabelY = arc4random_uniform(4)
            let rdNum = arc4random_uniform(2) == 0 ? 2 : 4
            
            while(b[Int(rnlabelX)][Int(rnlabelY)] != 0)
            {
                rnlabelX = arc4random_uniform(4)
                rnlabelY = arc4random_uniform(4)
                
            }
            
            b[Int(rnlabelX)][Int(rnlabelY)] = rdNum
            let labelNumber = Int(100 + 4 * rnlabelX + rnlabelY)
            self.ConvertNumLabel(numlabel: labelNumber, value: String(rdNum))
            self.transfer()
        }
        else
        {
            if checkLose()
            {
                self.lose = true
                let alert = UIAlertController(title: "GameOver", message: "You Lose", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    func ConvertNumLabel (numlabel: Int, value: String)
    {
        let label = self.view.viewWithTag(numlabel) as! UILabel
        label.text = value
    }
    
    func changeBackColor (numlabel: Int, color: UIColor)
    {
        let label = self.view.viewWithTag(numlabel) as! UILabel
        label.backgroundColor = color
    }
    
    func transfer()
    {
        for i in 0 ..< 4
        {
            for j in 0 ..< 4
            {
                let numlabel = 100 + (i*4) + j
                ConvertNumLabel(numlabel: numlabel, value: String(b[i][j]))
                switch(b[i][j])
                {
                    
                case 0:changeBackColor(numlabel: numlabel, color: UIColor.cyan)
                case 2:changeBackColor(numlabel: numlabel, color: UIColor.purple)
                case 4:changeBackColor(numlabel: numlabel, color: UIColor.magenta)
                case 8:changeBackColor(numlabel: numlabel, color: UIColor.gray)
                case 16:changeBackColor(numlabel: numlabel, color: UIColor.yellow)
                case 32:changeBackColor(numlabel: numlabel, color: UIColor.red)
                case 64:changeBackColor(numlabel: numlabel, color: UIColor.orange)
                case 128:changeBackColor(numlabel: numlabel, color: UIColor.brown)
                case 256:changeBackColor(numlabel: numlabel, color: UIColor.blue)
                case 512:changeBackColor(numlabel: numlabel, color: UIColor.darkGray)
                case 1024:changeBackColor(numlabel: numlabel, color: UIColor.lightGray)
                case 2048:changeBackColor(numlabel: numlabel, color: UIColor.green)
                    
                default:
                    break
                }
            }
        }
    }
    func GetScore(value: Int)
    {
        score.text = String(Int(score.text!)! + value)
    }
    @IBAction func Restart(_ sender: UIButton) {
        for i in 0 ..< 4
        {
            for j in 0 ..< 4
            {
                b[i][j] = 0
            }
        }
        self.transfer()
        self.lose = false
        self.randomNum(-1)
        
    }
}

