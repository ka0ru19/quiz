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
    
    //現在の問題数
    var sum:Int = 0
    
    //正解数
    var correctAnswer:Int = 0
    
    //乱数
    var random:Int = 0
    
    //クイズを格納する配列
    var quizArray = [NSMutableArray]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons: Array<UIButton>!

    //正誤判定の画像（マルバツ）
    @IBOutlet var AnswerMark: UIImageView!
    let AnswerTrue:UIImage!  = UIImage(named: "true.png")
    let AnswerFalse:UIImage! = UIImage(named: "false.png")
    //var AnsAnimeArray = [NSArray]()
    var AnsTrueAnimeArray : Array<UIImage> = []
    var AnsFalseAnimeArray : Array<UIImage> = []
    
    
    override func viewDidLoad() { //アプリ起動後の最初の処理
        super.viewDidLoad()
        
        AnsTrueAnimeArray.append(AnswerTrue)
        AnsFalseAnimeArray.append(AnswerFalse)
        AnswerMark.image = nil
        
        //添字[5]は問題番号を示す検番
        //------------------------ここから下にクイズを書く------------------------//
        quizArray.append(["問題文1 都道府県の数は？","47","51","53",1,1])
        quizArray.append(["問題文2 孫さん","au","docomo","softbank",3,2])
        quizArray.append(["問題文3 Steve Jobs","Apple","Microsoft","SONY",1,3])
        quizArray.append(["問題文4 iOSのプログラミング言語","Java","Ruby","Swift",3,4])
        quizArray.append(["問題文5 石の上にも","ぼたもち","三年","蜂",2,5])
        quizArray.append(["問題文6 M-T-W-T-?-S-S","F","K","R",1,6])

        //------------------------ここから下にクイズを書く------------------------//
        choiceQuiz()  //シャッフルする
    }
    
    func choiceQuiz() {
        //クイズの問題文をシャッフルしてTextViewにセット
        //乱数の代入
        if quizArray.count==0 {
            random = 0
        }else{
        random = Int(arc4random_uniform(UInt32(quizArray.count)))
        }
        //問題文(quizArray[random][0])をテキストラベルに代入
        quizTextView.text = quizArray[random][0] as NSString
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        for var i = 0; i < choiceButtons.count; i++ {
            choiceButtons[i].setTitle(quizArray[random][i+1] as NSString, forState: .Normal)
            
            //どのボタンが押されたか判別するためのtagをセット
            choiceButtons[i].tag = i + 1;
            
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        print("\(sum)問目の問題( 残り\(questionNumber-sum+1)問 ), ")
        println("random　-> \(random)")
        print("\(sum)番目の問題(Q\(quizArray[random][5] as Int)) は \(sender.tag)番目の選択肢を選択 ")
        AnswerMark.animationRepeatCount = 10; //n回
        AnswerMark.animationDuration = 5; //0.8秒に設定
        if quizArray[random][4] as Int == sender.tag {
            //正解数を増やす
            correctAnswer++
            println("-> 正解")
            AnswerMark.animationImages = AnsTrueAnimeArray
        }else{
            println("-> 不正解")
            AnswerMark.animationImages = AnsFalseAnimeArray
        }
        // アニメーションを開始
        AnswerMark.startAnimating()
        let delay = 0.6 * Double(NSEC_PER_SEC) //delay秒で正誤マークの表示を終了
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) { //マーク表示終了後の処理
            self.AnswerMark.stopAnimating() //表示終了
            self.AnswerMark.image = nil
            
            //解いた問題数の合計が予め設定していた問題数に達したら
            if self.sum == self.questionNumber {
                self.performSegueToResult()  //結果画面へ
            }else{
                self.quizArray.removeAtIndex(self.random)  //添字[random]の問題を排除
                self.choiceQuiz() //次の問題を選出
            }

        }
        
        
        println("正答数:\(correctAnswer)\n")
        /*
        //解いた問題数の合計が予め設定していた問題数に達したら
        if sum == questionNumber {
            performSegueToResult()  //結果画面へ
        }else{
        quizArray.removeAtIndex(random)  //添字[random]の問題を排除
        choiceQuiz()
        }
*/
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            var ResultView : ResultViewController = segue.destinationViewController as ResultViewController

            ResultView.questionNumber = self.questionNumber
            ResultView.correctAnswer  = self.correctAnswer  //ResultViewのcorrectAnswerにcorrectAnswerを代入
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


