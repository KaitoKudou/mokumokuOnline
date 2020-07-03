//
//  EnterModel.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/27.
//  Copyright © 2020 工藤海斗. All rights reserved.
// 入室APIのモデル

import Foundation

struct EnterJson:Codable{
    let id:Int?
    let roomId:Int?
    //let user_count:Int?
    
    enum CodingKeys: String, CodingKey {
      case id = "user_id"
      case roomId = "room_id"
    }
}

