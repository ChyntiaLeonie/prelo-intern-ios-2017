//
//  ViewController.swift
//  prelo-intern-ios-2017
//
//  Created by Chyntia Leonie Andreas on 5/17/17.
//  Copyright © 2017 Chyntia Leonie Andreas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var token : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "prelo.png")
        let imageView = UIImageView(image: image)
        imageView.image = imageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView = imageView
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0, green: 0.655, blue: 0.616, alpha: 1)
        accessAPI()

        while(self.token=="")
        {
            
        }
        print("Token",self.token)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func accessAPI(){
        let username_or_email = "frontend"
        let password = "intern"
        
        let req = NSMutableURLRequest(URL:NSURL(string:"https://dev.prelo.id/api/auth/login")!)
        
        let bodyData = "username_or_email=" + username_or_email + "&password=" + password
        
        req.HTTPMethod = "POST"
        req.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(req,completionHandler: {(data,response,error) in
            
            if let convertedJsonIntoDict = try? NSJSONSerialization.JSONObjectWithData(data!, options: []){
                
                // Print out dictionary
                //print("convertedJsonIntoDict \(convertedJsonIntoDict)")
                
                let isiData = convertedJsonIntoDict["_data"]!
                self.token = isiData!["token"] as! String
            } else {
                print("masuknya kesini")
            }
            }
        )
        dataTask.resume()
    }


}

