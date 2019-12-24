//
//  ViewController.swift
//  semoEXt
//
//  Created by IUser on 23/12/2019.
//  Copyright © 2019 IUser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var imageView: UIImageView!
       
       @IBAction func openApp(_ sender: Any) {
           let aplication = UIApplication.shared
           let secApp = "editorChords://?getImage=true"
           let url = URL(string: secApp)!
           _ = URLComponents(url: url, resolvingAgainstBaseURL: true)
         
           
           if aplication.canOpenURL(url) {
               aplication.open(url, options: [:], completionHandler: nil)
           }else {
               print("not have app")
           }
           
       }
    
   
       override func viewDidLoad() {
           super.viewDidLoad()
         print("did")
           // Do any additional setup after loading the view.
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(featch), name: UIApplication.willEnterForegroundNotification, object: nil)
        print("vill")
       // featch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("DA")
         featch()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
   @objc func featch() {
        print("featc   ---------")
        if let prefs = UserDefaults(suiteName: "group.com.blabla.semoEXt"){
            if let imageData = prefs.object(forKey:"Image") as? NSData{
                DispatchQueue.main.async(execute: {() -> Void in
                    self.imageView.image = UIImage(data: imageData as Data)
                   // prefs.removeObject(forKey: "Image") // удаляем чтоб если что было путсо
                }
                    
                )
                
            }
           }
       }


}

