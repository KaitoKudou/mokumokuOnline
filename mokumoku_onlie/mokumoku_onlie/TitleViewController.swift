//
//  TitleViewController.swift
//  mokumoku_onlie
//
//  Created by 工藤海斗 on 2020/06/27.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import SafariServices

class TitleViewController: UIViewController, SFSafariViewControllerDelegate {
    var setitngUseridViewController = SetitngUseridViewController()
    var titleViewModel = TitleViewModel()
    var userDefaults = UserDefaults()
    let shopUrl:String = "https://249859bdb21f.ngrok.io/images?id="
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ud = UserDefaults.standard
        let firstLunchKey = "firstLunch"
        if ud.bool(forKey: firstLunchKey) {
            ud.set(false, forKey: firstLunchKey)
            ud.synchronize()
            self.performSegue(withIdentifier: "toSettingUserIdScene", sender: nil)
        }
        
        print("userIDのキー → \(setitngUseridViewController.settingKey)")
        let userId = userDefaults.integer(forKey: setitngUseridViewController.settingKey) // user_idを取得
        print("保存されたあなたのIDは \(userId) です。")
    }
    
    @IBAction func ParticipationButton(_ sender: Any) {
        titleViewModel.fetchRoomId(completion: { [weak self] roomId in
            let roomId = roomId
            print(roomId) // このroomIdを定期実行に持っていきたい
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MomokuViewController") as? MomokuViewController
            viewController?.roomId = roomId
            self?.present(viewController!, animated: true, completion: nil)
            
        }, error: { [weak self]  in
            let alert = UIAlertController(title: "error", message: "roomIdが取得できませんでした", preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okayButton)

            self?.present(alert, animated: true, completion: nil)
            
        })
    }
    
    @IBAction func goShopButton(_ sender: Any) {
        let userId = userDefaults.integer(forKey: setitngUseridViewController.settingKey) // user_idを取得
        guard let requestURL = URL(string: "https://249859bdb21f.ngrok.io/images?id=\(userId)") else {
            return
        }
        print(requestURL)
        let safariViewController = SFSafariViewController(url: requestURL)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
