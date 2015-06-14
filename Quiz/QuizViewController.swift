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
    
    //カウンタ
    var count:Float = 0.0
    
    //タイマー
    var timer:NSTimer!
    
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
//    var ans = [UIImage]()
    var AnsFalseAnimeArray : Array<UIImage> = []
    
    
    override func viewDidLoad() { //アプリ起動後の最初の処理
        super.viewDidLoad()
        
        
        AnsTrueAnimeArray.append(AnswerTrue)
        AnsFalseAnimeArray.append(AnswerFalse)
//        AnswerMark.image = nil
        
        //添字[5]は問題番号を示す検番
        //------------------------ここから下にクイズを書く------------------------//
        //quizArray.append(["問題文X ...?","選択肢1","選択肢2","選択肢3",AnsNumber(Int),X])
        quizArray.append(["問題文1 都道府県の数は？","47","51","53",1,1])
        quizArray.append(["問題文2 孫さん","au","docomo","softbank",3,2])
        quizArray.append(["問題文3 Steve Jobs","Apple","Microsoft","SONY",1,3])
        quizArray.append(["問題文4 iOSのプログラミング言語","Java","Ruby","Swift",3,4])
        quizArray.append(["問題文5 石の上にも","ぼたもち","三年","蜂",2,5])
        quizArray.append(["問題文6 M-T-W-T-?-S-S","F","K","R",1,6])
        quizArray.append(["問題文7 一番高いのは","東京都庁","横浜ランドマークタワー","六本木ヒルズ",2,7])
        //------------------------ここから下にクイズを書く------------------------//
        
//        let image = UIImage(named: "true.png")!
//        AnswerMark.image = image
//        AnswerMark.alpha = 1.0
//        UIView.animateWithDuration(5.0, animations: { () -> Void in
//            // self.AnswerMark.alpha = 0.0
//            
//        }) { (flag) -> Void in
//            // self.AnswerMark.alpha = 0.0
//            println("aaa")
//        }
        
//        UIView.beginAnimations("some", context: nil)
//        
//        UIView.setAnimationDuration(0.5)
//        UIView.setAnimationDelay(2.0)
//        
//        AnswerMark.alpha = 0.5
//        
//        UIView.commitAnimations()
        
        delay(3.0, closure: { () -> () in
            self.AnswerMark.alpha = 0.0
        })
        
        choiceQuiz()  //シャッフルする
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "OnUpdate:", userInfo: nil, repeats: true)
        timer.fire() // タイマー起動
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
            
//            choiceButtons[i].addTarget(self, action:"start:", forControlEvents: .TouchUpInside)
            
            
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        print("\(sum)問目の問題( 残り\(questionNumber-sum+1)問 ), ")
        println("random　-> \(random)")
        print("\(sum)番目の問題(Q\(quizArray[random][5] as Int)) は \(sender.tag)番目の選択肢を選択 ")
//        AnswerMark.animationRepeatCount = 10; //n回
//        AnswerMark.animationDuration = 5; //0.8秒に設定

        AnswerMark.alpha = 1.0
        
        if quizArray[random][4] as Int == sender.tag {
            //正解数を増やす
            correctAnswer++
            println("-> 正解")
            let image = UIImage(named: "true.png")!
            AnswerMark.image = image
            //AnswerMark.animationImages = AnsTrueAnimeArray
        }else{
            println("-> 不正解")
            let image = UIImage(named: "false.png")!
            AnswerMark.image = image
            // AnswerMark.animationImages = AnsFalseAnimeArray
        }
        
        delay(0.6, closure: { () -> () in
            self.AnswerMark.alpha = 0.0
            self.AnswerMark.image = nil
            
            //解いた問題数の合計が予め設定していた問題数に達したら
            if self.sum == self.questionNumber {
                self.performSegueToResult()  //結果画面へ
            }else{
                self.quizArray.removeAtIndex(self.random)  //添字[random]の問題を排除
                self.choiceQuiz() //次の問題を選出
            }
        })
        
//        //解いた問題数の合計が予め設定していた問題数に達したら
//        if self.sum == self.questionNumber {
//            self.performSegueToResult()  //結果画面へ
//        }else{
//            self.quizArray.removeAtIndex(self.random)  //添字[random]の問題を排除
//            self.choiceQuiz() //次の問題を選出
//        }

        
        // アニメーションを開始
//        AnswerMark.startAnimating()
//        let delay = 0.6 * Double(NSEC_PER_SEC) //delay秒間、正誤マークの表示を終了
//        let animatime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        dispatch_after(animatime, dispatch_get_main_queue()) { //マーク表示終了後の処理
//            self.AnswerMark.stopAnimating() //表示終了
//            self.AnswerMark.image = nil
//            
//            //解いた問題数の合計が予め設定していた問題数に達したら
//            if self.sum == self.questionNumber {
//                self.performSegueToResult()  //結果画面へ
//            }else{
//                self.quizArray.removeAtIndex(self.random)  //添字[random]の問題を排除
//                self.choiceQuiz() //次の問題を選出
//            }
//
//        }
        
        
        
        count = 5
        
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
    
    
//    //タイマー機能
//    func start(sender:UIButton){
//        /*if timer.valid == true {
//            //タイマーをリセット
//            timer.invalidate()
//            //count = 0
//        }
//*/
//        //タイマーの生成。0.1秒ごとに" timer: "を呼び出す
//        timer.fire()
//    }
    func OnUpdate(timer : NSTimer){
        self.count -= 1
        println(self.count)
        
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


