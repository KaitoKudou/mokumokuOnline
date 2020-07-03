//
//  MokumokuExitViewModel.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/28.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import Alamofire

class MokumokuExitViewModel {
    
    var setitngUseridViewController = SetitngUseridViewController()
    var userDefaults = UserDefaults.standard
    
    // このメソッドで退出APIを叩くよ
    func serverSideUserIdDelete(userId:Int){
        
        let userId = userDefaults.integer(forKey: setitngUseridViewController.settingKey) // user_idを取得
        print("退出時、サーバ側で削除するuserId　→ \(userId)")
        
        guard let requestURL = URL(string: "https://249859bdb21f.ngrok.io/users/\(userId)") else {
            return
        }
        print(requestURL)
        
        AF.request(requestURL, method: .delete, parameters: ["user_id":userId], encoding: JSONEncoding.default).responseJSON { response in
            // { response in ...} の部分は完了ハンドラとして渡される
            // その完了ハンドラが渡されるのは通信完了後
            print("----------------------------------")
            print(response)
            print("----------------------------------")
        }
    }
    
}
