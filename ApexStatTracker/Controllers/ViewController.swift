//
//  ViewController.swift
//  ApexStatTracker
//
//  Created by Alexander Gunnarsson on 2019-04-02.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Desc : Decodable{
    
    let global : Globalstats
    let realtime: Realtimestats
}

struct Globalstats : Decodable{
    
    let name : String
    let level : Int
    let platform : String
    let toNextLevelPercent : Int
    
}

struct Realtimestats : Decodable{
    
   let lobbyState : String
    var isOnline : Int
    var isInGame : Int
    let canJoin : Int
    let partyFull : Int
    let selectedLegend : String
    
    
}


class ViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var statsPlayerNameLabel: UILabel!
    @IBOutlet weak var isPlayingLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var legendImageView: UIImageView!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    
    // Api key:  BpLbBtuTjKttwEZroV0V
    
    let STAT_URL = "http://api.mozambiquehe.re/bridge?version=2&platform=PC&player=lemenator95&auth=BpLbBtuTjKttwEZroV0V"

    override func viewDidLoad() {
        super.viewDidLoad()

        getPlayerData()
        
    }

    
    

    // JSON PARSE
    func getPlayerData(){
        guard let url = URL (string: STAT_URL)else {return}
        
        URLSession.shared.dataTask(with: url){(data,response,error)
            in
            guard let data = data else {return}
            
            do{
                
                let desc = try JSONDecoder().decode(Desc.self, from: data)
                
                print(desc.global)
                print(desc.realtime)
                
                DispatchQueue.main.async{
                self.statsPlayerNameLabel.text = String(desc.global.name)
                self.currentLevelLabel.text = String(desc.global.level)
                    if desc.realtime.isOnline == 1{
                        self.onlineStatusLabel.text = "Online"
                    }else{
                      self.onlineStatusLabel.textColor = .red
                        self.onlineStatusLabel.text = "Offline"
                    }
                }
                
            }catch let jsonError{
                print(jsonError)
            }
            
            
            }.resume()
        
    }
    
    
    // update UI
    func updateUiData(){
        
    }
    
    
    @IBAction func detailScreenButton(_ sender: UIButton) {
        
        
    }
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StatsCollectionViewCell
        
        cell?.killCount.text = String(indexPath.row)
        
        return cell!
    }
    
    
    
}

