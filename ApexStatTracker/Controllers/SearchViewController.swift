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
    
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlayerViewController") as? ViewController
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    
    }
    
    
 
        
    @IBAction func searchButton(_ sender: Any) {
        
        if(searchPlayerTextField.text != ""){
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.searchedPlayerName = searchPlayerTextField.text!
            
            
        }
        
        else {
           let alert = UIAlertController(title: "Error", message: "Please enter playername to search for", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (Action) in}
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        }
        
        
    }
    

}
