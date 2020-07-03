//
//  SetitngUseridViewController.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/28.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class SetitngUseridViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var showUseridLabel: UILabel!
    
    var setitngUseridViewModel = SetitngUseridViewModel()
    var userID:Int!
    let settingKey = "user_id" // 設定値を扱うキー
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = "あなたのユーザIDが下に表示されます。確認したらしたのボタンを押してください。"
        textView.isEditable = false
        
        setitngUseridViewModel.FetchEnterData(completion: { userID in
            self.userID = userID
            self.showUserID(userID: userID)
        })
    }
    
    // userIDの永続化にはUserDafaultsを使う。異論は認めん。
    func showUserID(userID:Int){
        self.userID = userID
        print(self.userID as Int)
        let settings = UserDefaults.standard
        settings.set(userID, forKey: settingKey)
        settings.synchronize()
        showUseridLabel.text = "あなたのIDは \(self.userID as Int) です"
        let userID = settings.integer(forKey: settingKey)
        print("あなたのユーザIDは \(userID) です。")
    }
    
    @IBAction func toTitileViewButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
