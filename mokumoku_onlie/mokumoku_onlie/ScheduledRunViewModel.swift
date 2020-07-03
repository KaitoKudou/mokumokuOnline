//
//  ScheduledRunViewModel.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/27.
//  Copyright © 2020 工藤海斗. All rights reserved.
// ここで、定期実行のAPIを叩く

import Foundation
import Alamofire

class ScheduledRunViewModel {
    
    
    // このメソッドで定期実行APIを叩くよ
    func fetchScheduledRunData(roomId:Int ,completion: @escaping (_ userCount:Int) -> Void){
        guard let requestURL = URL(string: "https://249859bdb21f.ngrok.io/rooms/\(roomId)") else {
            return
        }
        print(requestURL)
        
        AF.request(requestURL, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            // { response in ...} の部分は完了ハンドラとして渡される
            // その完了ハンドラが渡されるのは通信完了後
            print("----------------------------------")
            print(response)
            print("----------------------------------")
            guard let data = response.data else {return}
            let decoder = JSONDecoder()
            
            guard let scheduledRun = try? decoder.decode(ScheduledRunJson.self, from: data) else {
                return
            }
            
            guard let userCount:Int = scheduledRun.user_count else {return}
            print(userCount)
            completion(userCount)
            
        }
    }
}
