//
//  ViewController.swift
//  prelo-intern-ios-2017
//
//  Created by Chyntia Leonie Andreas on 5/17/17.
//  Copyright © 2017 Chyntia Leonie Andreas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "prelo.png")
        let imageView = UIImageView(image: image)
        imageView.image = imageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView = imageView
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0, green: 0.655, blue: 0.616, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

