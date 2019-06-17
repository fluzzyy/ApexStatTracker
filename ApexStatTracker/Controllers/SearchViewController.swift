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
   
    @IBOutlet weak var searchHistoryTextView: UITextView!
    
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlayerViewController") as? ViewController
   
        var myArray = UserDefaults.standard.array(forKey: "history") ?? []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
       
        
        searchHistoryTextView.text = String(format: "%@", myArray)

    
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
          searchHistoryTextView.text = String(format: "%@", myArray)
    }
  
    
    @IBAction func searchButton(_ sender: Any) {
        
       searchPlayerTextField.resignFirstResponder()
    
        if(searchPlayerTextField.text != ""){
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.searchedPlayerName = searchPlayerTextField.text!
            myArray.append(String(describing: searchPlayerTextField.text!))
            UserDefaults.standard.set(myArray, forKey: "history")
            searchHistoryTextView.text = String(format: "%%", myArray)
            

            
        }else {
           let alert = UIAlertController(title: "Error", message: "Please enter playername to search for", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (Action) in}
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        }
      
        
    }
    
}
