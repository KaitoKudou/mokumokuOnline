//
//  MomokuViewController.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/27.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class MomokuViewController: UIViewController {
    
    
    var scheduledRunViewModel = ScheduledRunViewModel()
    var mokumokuExitViewModel = MokumokuExitViewModel()
    var timer : Timer!
    var startTime = Date()
    var roomId:Int!
    var userCount:Int = 0 {
        didSet{
            if oldValue != userCount{
                self.placementImage(userCount: userCount)
            }
        }
    }
    var setitngUseridViewController = SetitngUseridViewController()
    var userDefaults = UserDefaults.standard
    let imageName = ["sample2.png", "sample3.png", "sample4.png", "sample2.png", "sample3.png", "sample4.png",
                     "sample2.png", "sample3.png"]
    var newImageName = [String]()
    var imageTag = [0, 1, 2, 3, 4, 5, 6, 7]
    @IBOutlet weak var timerMinute: UILabel! // 分
    @IBOutlet weak var timerSecond: UILabel! // 秒
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var roomIdLabel: UILabel!
    
    @IBOutlet weak var imageView00: UIImageView!
    @IBOutlet weak var imageView01: UIImageView!
    @IBOutlet weak var imageView02: UIImageView!
    @IBOutlet weak var imageView03: UIImageView!
    @IBOutlet weak var imageView04: UIImageView!
    @IBOutlet weak var imageView05: UIImageView!
    @IBOutlet weak var imageView06: UIImageView!
    @IBOutlet weak var imageView07: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.timerMinute.text = "00"
        self.timerSecond.text = "00"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //scheduledFetch()
        startTimer()
        self.roomIdLabel.text = "\(self.roomId as Int)号室"
        print("roomID:\(self.roomId as Int)")
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
    func chengeNumberOfPeopleLabel(userCount:Int){
        //print(titleViewModel.userCount)
        self.numberOfPeopleLabel.text = "\(userCount)人"
    }
    
    @objc func fetchData(){
        self.scheduledRunViewModel.fetchScheduledRunData(roomId: self.roomId, completion: { [weak self] userCount in
            self?.chengeNumberOfPeopleLabel(userCount: userCount)
            self?.userCount = userCount
        })
    }
    
    // 退出ボタン
    @IBAction func exitButton(_ sender: Any) {
        
        if timer != nil{
            timer.invalidate()
            self.timerMinute.text = "00"
            self.timerSecond.text = "00"
        }
        let userId = userDefaults.integer(forKey: setitngUseridViewController.settingKey) // user_idを取得
        mokumokuExitViewModel.serverSideUserIdDelete(userId: userId)
    }
    
    func startTimer(){ // ここでAPI叩くのおかしいけど、許して....
        
        if timer != nil{
            // timerが起動中なら一旦破棄する
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
        startTime = Date()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        
        // fmod() 余りを計算
        let minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        let second = (Int)(fmod(currentTime, 60))
        
        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        
        timerMinute.text = sMinute
        timerSecond.text = sSecond
        
    }
    
    func placementImage(userCount:Int){
        let shuffledImageName = imageName.shuffled()
        print(shuffledImageName)
        
        for i in 0..<userCount {
            newImageName.append(shuffledImageName[i])  //人数分前から画像の名前を取ってくる
        }
        let imageViewArray = [imageView00, imageView01, imageView02, imageView03, imageView04,
                              imageView05, imageView06, imageView07]
        
        for i in 0..<8 {
            imageViewArray[i]?.image = UIImage(named: shuffledImageName[i])
            if i > userCount-1{
                imageViewArray[i]?.image = nil
            }
        }
        
        /*for i in imageTag {
            switch i {
            case 0:
                imageView00.image = UIImage(named: newImageName[i])
            case 1:
                imageView01.image = UIImage(named: newImageName[i])
            case 2:
                imageView02.image = UIImage(named: newImageName[i])
            case 3:
                imageView03.image = UIImage(named: newImageName[i])
            case 4:
                imageView04.image = UIImage(named: newImageName[i])
            case 5:
                imageView05.image = UIImage(named: newImageName[i])
            case 6:
                imageView06.image = UIImage(named: newImageName[i])
            case 7:
                imageView07.image = UIImage(named: newImageName[i])
            default:
                break
            }
        }*/
    }
    
    
}
