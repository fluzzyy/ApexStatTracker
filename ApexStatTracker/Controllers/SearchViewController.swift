//
//  SearchViewController.swift
//  ApexStatTracker
//
//  Created by Alexander Gunnarsson on 2019-04-24.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchPlayerTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func searchButton(_ sender: Any) {
        
        if(searchPlayerTextField.text != ""){
        
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlayerViewController") as? ViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.searchedPlayerName = searchPlayerTextField.text!
                        
        }else {
           let alert = UIAlertController(title: "Error", message: "Please enter playername to search for", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (Action) in}
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        }
        
    }
    

}
