//
//  ResultViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var questionNumber:Int = 0
    var correctAnswer:Int = 0
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBOutlet weak var TextMessege: UITextView!
    
    @IBOutlet weak var ResultImage: UIImageView!
    let ResultPic0: UIImage! = UIImage(named: "God01.png")
    let ResultPic1: UIImage! = UIImage(named: "human01.png")
    let ResultPic2: UIImage! = UIImage(named: "monkey01.png")
    let ResultPic3: UIImage! = UIImage(named: "horse01.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pointは正答率(0.0~1.0)
        var point :Double = Double(correctAnswer) / Double(questionNumber)
        
        println("Result画面: 正答数/問題数 -> \(correctAnswer)/\(questionNumber), 正答率 -> \(point*100)%")
        ResultLabel.text = String("正答率 -> \(point*100)%")
        
        if point == 1 {
            TextMessege.text = String("全問正解！\nおめでとうございます！\nあなたの常識度は神レベルです。")
            ResultImage.image = ResultPic0
        } else if point > 0.7 {
            TextMessege.text = String("あなたの常識度は人間レベルです。")
            ResultImage.image = ResultPic1
        } else if point > 0.3 {
            TextMessege.text = String("あなたは常識度は猿レベルです。")
            ResultImage.image = ResultPic2
        } else {
            TextMessege.text = String("あなたは常識度は馬レベルです。\n頑張りましょう。")
            ResultImage.image = ResultPic3
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
