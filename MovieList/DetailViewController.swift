//
//  DetailViewController.swift
//  MovieList
//
//  Created by Betty Jing on 2/6/16.
//  Copyright © 2016 bettydabomb. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
  
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = movie["title"] as? String
        titleLabel.text = title
        let overview = movie["overview"]
        overviewLabel.text = overview as?String
        
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"]  as? String {
           let imageUrl = NSURL(string: baseUrl + posterPath)
         posterImageView.setImageWithURL(imageUrl!) //thanks to cocapod
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    

}
