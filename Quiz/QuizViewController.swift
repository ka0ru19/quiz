//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //出題数
    var questionNumber:Int = 5
    //何問正解したかの共有
    var correntAnswer:Int = 0
    //randomの共有
    var random:Int = 0
    //解いた問題数の共有
    var sum:Int = 0
    //Quiz配列
    var quiz=[NSArray]()
    //weak参照
    @IBOutlet weak var QuizText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------------ここから下にクイズを書く------------------------//
        quiz.append(["問題文","選択肢","選択肢2","選択肢3",1])
        quiz.append(["問題文2","選択肢","選択肢2","選択肢3",2])
        quiz.append(["問題文2","選択肢","選択肢2","選択肢3",2])
        quiz.append(["問題文2","選択肢","選択肢2","選択肢3",2])
        quiz.append(["問題文2","選択肢","選択肢2","選択肢3",2])
        quiz.append(["問題文2","選択肢","選択肢2","選択肢3",2])
        quiz.append(["問題文2","選択肢","選択肢2","選択肢3",2])
        
        //------------------------ここから下にクイズを書く------------------------//

        random = Int(arc4random()%UInt32(quiz.count))
        QuizText.text=quiz[random][0] as NSString
        
    }
    @IBAction func Select1() {
        sum++
        if 1==quiz[random][4] as NSObject{
            current()
        }
        if(sum == questionNumber){
            tapBtn()
        }
    }
    @IBAction func Select2() {
        sum++
        if 2==quiz[random][4] as NSObject {
            current()
        }
        if sum == questionNumber{
            tapBtn()
        }
    }
    @IBAction func Select3() {
        sum++
        if 3==quiz[random][4] as NSObject {
            current()
        }
        if sum == questionNumber{
            tapBtn()
        }
    }
    func current(){
        println("true")
        correntAnswer++
    }
    func tapBtn() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/
}
