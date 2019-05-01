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
    var playerModel = PlayerDataModel()
    var searchedPlayerName : String = ""

   
    var globalStatsArray : [(totalKills : String, kdRatio : String, winsSeason : String,killsSeason : String)] = []
    static var legendArray = [Legendmodel]()
    
    
    
    
    // Outlets
    @IBOutlet weak var statsPlayerNameLabel: UILabel!
    @IBOutlet weak var isPlayingLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var legendImageView: UIImageView!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet weak var detailScreenButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsCollectionView.delegate = self
        statsCollectionView.dataSource = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

       
        
        detailScreenButton.layer.cornerRadius = 20
        statsCollectionView.layer.cornerRadius = 20
        statsCollectionView.layer.borderWidth = 1
        
        getPlayerData(STAT_URL: "http://api.mozambiquehe.re/bridge?version=2&platform=PC&player=\(searchedPlayerName)&auth=BpLbBtuTjKttwEZroV0V")
        
    }
    
    
    

    // JSON PARSE
    func getPlayerData(STAT_URL : String){
        
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        
        
        Alamofire.request(STAT_URL).responseJSON { (response) in
            if response.result.isSuccess{
            
                self.desc = JSON(response.result.value!)
                
//                let apa = self.desc["total"]
//                var datan = ""
//                for (key , values) in apa {
//
//                    print("Key: \(key)")
//                    print("Value: \(values)")
//             
//
//                }
          
                self.playerModel.playerTotalKills = self.desc["total"]["kills"]["value"].stringValue
                self.playerModel.playerKd = self.desc["total"]["kd"]["value"].stringValue
                self.playerModel.playerWinsSeason = self.desc["total"]["wins_season_1"]["value"].stringValue
                self.playerModel.playerKillsSeason = self.desc["total"]["kills_season_1"]["value"].stringValue
                self.playerModel.playerName = self.desc["global"]["name"].stringValue
                self.playerModel.currentLevel = self.desc["global"]["level"].stringValue
                self.playerModel.isOnline = self.desc["realtime"]["isOnline"].intValue
                self.playerModel.isIngame = self.desc["realtime"]["isInGame"].intValue
                
              
                let bangalore = Legendmodel(name: "Bangalore", kills: self.desc["legends"]["all"]["Bangalore"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "bangalore")!)
                ViewController.legendArray.append(bangalore)
                
                 let bloodhound = Legendmodel(name: "Bloodhound", kills: self.desc["legends"]["all"]["Bloodhound"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "bloodhound")!)
                    ViewController.legendArray.append(bloodhound)

                let lifeline = Legendmodel(name: "Lifeline", kills: self.desc["legends"]["all"]["Lifeline"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "lifeline")!)
                ViewController.legendArray.append(lifeline)

                let gibraltar = Legendmodel(name: "Gibraltar", kills: self.desc["legends"]["all"]["Gibraltar"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "gibraltar")!)
                ViewController.legendArray.append(gibraltar)


                let caustic = Legendmodel(name: "Caustic", kills: self.desc["legends"]["all"]["Caustic"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "caustic")!)
                ViewController.legendArray.append(caustic)

                let mirage = Legendmodel(name: "Mirage", kills: self.desc["legends"]["all"]["Mirage"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "mirage")!)
                ViewController.legendArray.append(mirage)

                let wraith = Legendmodel(name: "Wraith", kills: self.desc["legends"]["all"]["Wraith"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "wraith")!)
                ViewController.legendArray.append(wraith)

                let octane = Legendmodel(name: "Octane", kills: self.desc["legends"]["all"]["Octane"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "octane")!)
                ViewController.legendArray.append(octane)

                let pathfinder = Legendmodel(name: "Pathfinder", kills: self.desc["legends"]["all"]["Pathfinder"]["data"]["kills"]["value"].stringValue, image: UIImage(named: "pathfinder")!)
                ViewController.legendArray.append(pathfinder)
                
                
                let currentHero = self.desc["legends"]["selected"]
                var heroName = ""
                for (key , value) in currentHero {
                    heroName = key
                }
                
                
                let imageUrl = URL(string: self.desc["legends"]["selected"][heroName]["ImgAssets"]["icon"].string!)
                let data = try? Data(contentsOf: imageUrl!)
                self.legendImageView.image = UIImage(data: data!)
               
                self.globalStatsArray.append((totalKills: "\(self.playerModel.playerTotalKills)",kdRatio: "\(self.playerModel.playerKd)", winsSeason : "\(self.playerModel.playerWinsSeason)", killsSeason: "\(self.playerModel.playerKillsSeason)"))
              
                self.updateUiData()
                
                
                self.statsCollectionView.reloadData()
                self.dismiss(animated: false, completion: nil)
                
            }
        }
        

    }
  
    
    // update UI
    func updateUiData(){
        
        self.statsPlayerNameLabel.text = playerModel.playerName
        self.currentLevelLabel.text = playerModel.currentLevel
        
        if (self.playerModel.isOnline == 1){
            
            self.onlineStatusLabel.text = "Online"
            
        }else{
            
            self.onlineStatusLabel.textColor = .red
            self.onlineStatusLabel.text = "Offline"
        }
        if(self.playerModel.isIngame == 1){
            self.isPlayingLabel.text = "Is playing right now!"
        }else{
            self.isPlayingLabel.text = "Player currently not in a game"
        }
        
        
    }
    
    // push to details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.nameLabel = playerModel.playerName
        vc.duperArray = ViewController.legendArray
        
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StatsCollectionViewCell
        let cell2 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! StatsCollectionViewCell
        let cell3 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! StatsCollectionViewCell
        let cell4 = statsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! StatsCollectionViewCell
        
        
        
        
        if indexPath.section == 0{
              cell1.killCount.text = self.globalStatsArray[indexPath.row].totalKills
            return cell1
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
        return cell1
        
        
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
     
      return self.globalStatsArray.count
    }
    

    
    
    
}
class Legendmodel{
    var legendName : String = ""
    var legendKills: String = ""
    var legendImage : UIImage?
    
    init(name: String, kills: String, image: UIImage) {
      self.legendName = name
        self.legendKills = kills
        self.legendImage = image
        
    }
}

