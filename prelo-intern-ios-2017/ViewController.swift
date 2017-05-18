//
//  ViewController.swift
//  prelo-intern-ios-2017
//
//  Created by Chyntia Leonie Andreas on 5/17/17.
//  Copyright © 2017 Chyntia Leonie Andreas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var token : String = ""
    var allProduct:NSMutableArray = NSMutableArray()
    var unDone : Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cellLoveList"
    
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
        
//        print("Token",self.token)
        accessProductAPI()
        while(unDone){
            
        }
        tableView.delegate = self
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
    
    func accessProductAPI(){
        let req = NSMutableURLRequest(URL:NSURL(string:"https://dev.prelo.id/api/me/lovelist")!)
        
        req.HTTPMethod = "GET"
        req.setValue("Token "+token, forHTTPHeaderField: "Authorization")
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(req,completionHandler: {(data,response,error) in
            
            if let convertedJsonIntoDict = try? NSJSONSerialization.JSONObjectWithData(data!, options: []){
                
                // Print out dictionary
                //print("convertedJsonIntoDict \(convertedJsonIntoDict)")
                
                var pLoveList : ProductLoveList = ProductLoveList()
                
                if let array = convertedJsonIntoDict["_data"] as? [AnyObject] {
                    for object in array {
                        pLoveList = ProductLoveList()
                        
                        if let prodImage = object["display_picts"] as? [AnyObject] {
                            pLoveList.imageProduct = prodImage[0] as! String
                        }
                        
                        pLoveList.titleProduct = object["name"]! as! String
                        pLoveList.priceProduct = object["price"]! as! Int

                        pLoveList.commentProduct = object["num_comment"]! as! Int

                        pLoveList.likeProduct = object["num_lovelist"]! as! Int

                        self.allProduct.addObject(pLoveList)
                    }
                }
                self.unDone = false;
                
            } else {
                print("masuknya kesini")
            }
            }
        )
        dataTask.resume()
    }
    

    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allProduct.count
    }
    
    // create a cell for each table view row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:LoveListCell = self.tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! LoveListCell
        
        let product = allProduct[indexPath.row] as! ProductLoveList
        
        if let url = NSURL(string: product.imageProduct) {
            if let data = NSData(contentsOfURL: url) {
                cell.imageProduct.image = UIImage(data: data)
            }        
        }
        
        cell.titleProduct.text = product.titleProduct
        cell.priceProduct.text = "Rp "+String(product.priceProduct)
        cell.commentProduct.text = String(product.commentProduct)
        cell.likeProduct.text = String(product.likeProduct)
        return cell;
    }
    
    
    // method to run when table view cell is tapped
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

