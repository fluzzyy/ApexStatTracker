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



class ViewController: UIViewController {
    
  
    var desc = JSON()
   
    
   
    var globalStatsArray : [(totalKills : String, platform : String, kdRatio : String, winsSeason : String,killsSeason : String)] = []
    
    // Outlets
    @IBOutlet weak var statsPlayerNameLabel: UILabel!
    @IBOutlet weak var isPlayingLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var legendImageView: UIImageView!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet weak var detailScreenButton: UIButton!
    
  static let STAT_URL = "http://api.mozambiquehe.re/bridge?version=2&platform=PC&player=fluzzyyy&auth=BpLbBtuTjKttwEZroV0V"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsCollectionView.delegate = self
        statsCollectionView.dataSource = self
        detailScreenButton.layer.cornerRadius = 20
        statsCollectionView.layer.cornerRadius = 20
        statsCollectionView.layer.borderWidth = 1

        getPlayerData()
    }
 

    // JSON PARSE
    func getPlayerData(){
        
        Alamofire.request(ViewController.STAT_URL).responseJSON { (response) in
            if response.result.isSuccess{
                self.desc = JSON(response.result.value!)
                
                let playerTotalKills = self.desc["total"]["kills"]["value"]
                let playerKd = self.desc["total"]["kd"]["value"]
                let playerPlatform = self.desc["global"]["platform"]
                let playerWinsSeason = self.desc["total"]["wins_season_1"]["value"]
                let killsSeason = self.desc["total"]["kills_season_1"]["value"]
           
                
               // let selectedHero = self.desc["legends"]["selected"][0]
             //   print (selectedHero)
                let currentHero = self.desc["legends"]["selected"]
                var heroName = ""
                
                for (key , value) in currentHero {
                    heroName = key
                }
                
                let imageUrl = URL(string: self.desc["legends"]["selected"][heroName]["ImgAssets"]["icon"].string!)
                let data = try? Data(contentsOf: imageUrl!)
                self.legendImageView.image = UIImage(data: data!)
               
              
                self.globalStatsArray.append((totalKills: "\(playerTotalKills)", platform: "\(playerPlatform)", "\(playerKd)", "\(playerWinsSeason)", "\(killsSeason)"))
              
                self.updateUiData()
                
                
                self.statsCollectionView.reloadData()
            }
        }
        

    }
  
    
    
    // update UI
    func updateUiData(){
        
        self.statsPlayerNameLabel.text = "\(self.desc["global"]["name"])"
        self.currentLevelLabel.text = "\(self.desc["global"]["level"])"
        
        if self.desc["realtime"]["isOnline"] == 1{
            
            self.onlineStatusLabel.text = "Online"
            self.isPlayingLabel.text = "Is playing right now!"
            
        }else{
            
            self.onlineStatusLabel.textColor = .red
            self.onlineStatusLabel.text = "Offline"
            self.isPlayingLabel.text = "Player currently not in a game"
        }
        
        
    }
    
    
    @IBAction func goToDetail(_ sender: Any) {
        
        performSegue(withIdentifier: "detail", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DetailViewController
        
       // vc.DetailplayerNameLabel = String(statsPlayerNameLabel.text!)
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StatsCollectionViewCell
         let cell2 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! StatsCollectionViewCell
         let cell3 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! StatsCollectionViewCell
          let cell4 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! StatsCollectionViewCell
     
        
        if indexPath.section == 0{
              cell.killCount.text = self.globalStatsArray[indexPath.row].totalKills
            return cell
        }else if indexPath.section == 1{
            cell2.kdRatioLabel.text = self.globalStatsArray[indexPath.row].kdRatio
            return cell2
        }else if indexPath.section == 2{
            
            cell3.winsSeasonLabel.text = self.globalStatsArray[indexPath.row].winsSeason
            return cell3
        }else if indexPath.section == 3{
            cell4.killsSeasonLabel.text = self.globalStatsArray[indexPath.row].killsSeason
            return cell4
        }
        return cell
        
        
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
     
      return self.globalStatsArray.count
       // return 2
    }
    

    
    
    
}

