//
//  TitleViewModel.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/28.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import Alamofire

class TitleViewModel {
    
    var setitngUseridViewController = SetitngUseridViewController()
    var userDefaults = UserDefaults.standard
    
    func fetchRoomId(completion: @escaping (_ roomId:Int) -> Void, error: @escaping () -> Void){
        let userId = userDefaults.integer(forKey: setitngUseridViewController.settingKey) // user_idを取得
        print(userId)
        
        guard let requestURL = URL(string: "https://249859bdb21f.ngrok.io/users/\(userId)") else {
            return
        }
        print(requestURL)
        
        AF.request(requestURL, method: .put, encoding: JSONEncoding.default).responseJSON { response in
            // { response in ...} の部分は完了ハンドラとして渡される
            // その完了ハンドラが渡されるのは通信完了後
            switch response.result{
                
            case .success(_):
                print("----------------------------------")
                print(response)
                print("----------------------------------")
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                
                guard let fetchRoom = try? decoder.decode(EnterJson.self, from: data) else {
                    return
                }
                
                guard let roomId:Int = fetchRoom.roomId else {return}
                print(roomId)
                completion(roomId)
                
            case .failure(_):
                print(response.error as Any)
                error()
            }
            
            
            
        }
    }
}
