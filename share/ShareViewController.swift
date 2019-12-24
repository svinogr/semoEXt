//
//  ShareViewController.swift
//  share
//
//  Created by IUser on 23/12/2019.
//  Copyright © 2019 IUser. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    private var imgData: Data?
    
    override func viewDidLoad() {
           super.viewDidLoad()
           placeholder = "Что то написать"
          self.datachment()
       }
       override func isContentValid() -> Bool {
           // Do validation of contentText and/or NSExtensionContext attachments here
           return true
       }

       override func didSelectPost() {
           // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
       
           // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
          // self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        self.saveDataToUserDefault(suitName: "group.com.blabla.semoEXt", dataKey: "Image", dataValue: imgData!)
        self.redirectToHostApp()
       }

       override func configurationItems() -> [Any]! {
           // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
           return []
       }
       
    func redirectToHostApp() {
        let url = URL(string: "semoExt://dataUrl=HHHHHH")
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")

        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
       func datachment() {
           let content = extensionContext?.inputItems[0] as! NSExtensionItem
        print("content", content)
           let contentType = kUTTypeImage as String
           print(contentType)
        for atachment in content.attachments! {
               if atachment.hasItemConformingToTypeIdentifier(contentType) {
                   atachment.loadItem(forTypeIdentifier: contentType, options: nil){
                       data, error in
                       if error == nil {
                        
                        if let url = data as? NSURL {
                            self.imgData = try! Data(contentsOf: url as URL )
                           
                            }
                        
                        
                        if let img = data as? UIImage{
                            self.imgData = img.pngData()
                            
                        }
                        
                       
                        
                        
                    }
                    
                }
                
                
            }
        }
    }
    

       func saveDataToUserDefault(suitName: String, dataKey: String, dataValue: Data) {
           if let prefs = UserDefaults(suiteName: suitName){
               prefs.removeObject(forKey: dataKey)
               prefs.set(dataValue, forKey: dataKey)
            prefs.synchronize()
           }
           
       }
       

}
