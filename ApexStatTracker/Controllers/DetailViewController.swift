//
//  DetailViewController.swift
//  ApexStatTracker
//
//  Created by Alexander Gunnarsson on 2019-04-10.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var legendDetailTable: UITableView!
    @IBOutlet weak var DetailplayerNameLabel: UILabel!
    
    
    var nameLabel  : String?
    var cellLegendName : String?
    var cellLegendImage: UIImageView?
    var cellLegendKills : String?
    
    
  
     var duperArray = [Legendmodel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        legendDetailTable.delegate = self
        legendDetailTable.dataSource = self
        
        DetailplayerNameLabel.text  = nameLabel
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
//         ViewController.legendArray.removeAll()
       legendDetailTable.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
      
       duperArray.removeAll()
        ViewController.legendArray.removeAll()
        
        
    }


}
extension DetailViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return duperArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = legendDetailTable.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
       
        
        let legend = duperArray[indexPath.row]
        
        
        
            cell.detailCellLegendNameLabel.text = legend.legendName
            cell.detailCellLegendKillsLabel.text = legend.legendKills
            cell.detailcellImageView.image = legend.legendImage
            if(legend.legendKills == ""){
            cell.detailCellLegendKillsLabel.text = "N/A"
            }
       
        
        return cell
    }
    
  
    
}
