//
//  SetitngUseridViewModel.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/27.
//  Copyright © 2020 工藤海斗. All rights reserved.
// 入室APIを実際にここで叩く

import Foundation
import Alamofire

class SetitngUseridViewModel{
    
    public var userID:Int! // 入室したユーザに一意に割り振られるID. 退出した時はnilにする.
    public var roomNumber:Int!
    public var userCount:Int!
    public var baseUrl = "https://249859bdb21f.ngrok.io/" // nglockのURLは起動するたびに変わるため、この変数を使用する
    
    
    // このメソッドで入室APIを叩くよ(初回起動時)
    func FetchEnterData(completion: @escaping (_ userID:Int) -> Void){
        
        guard let requestURL = URL(string: "\(baseUrl)users") else {
            return
        }
        print(requestURL)
        
        AF.request(requestURL, method: .post, parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            // { response in ...} の部分は完了ハンドラとして渡される
            // その完了ハンドラが渡されるのは通信完了後
            print("----------------------------------")
            print(response)
            print("----------------------------------")
            guard let data = response.data else {return}
            let decoder = JSONDecoder()
            
            guard let enter = try? decoder.decode(EnterJson.self, from: data) else {
                print("1")
                return
            }
            print("enter:\(enter)")
            guard let userID:Int = enter.id else { print("2")
                return
            }
            
            self.userID = userID
            
            
            print("userID:\(String(describing: self.userID))")
            
            //元の非同期処理の完了ハンドラの中で自前の完了ハンドラを呼び出す
            completion(self.userID)
            
        }
    }
}
