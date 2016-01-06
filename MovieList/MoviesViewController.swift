//
//  MoviesViewController.swift
//  MovieList
//
//  Created by Betty Jing on 1/5/16.
//  Copyright © 2016 bettydabomb. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var movies : [NSDictionary]? //array of movies consists of NSDictionary stuff. the question marks makes it so that the movies may be an array of dictionaries or nothing at all (in case the api breaks down or something)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate  = self

        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed" //lets us access the api.
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            //parses the JSON into NSdictionary. 
                            
                           self.movies = responseDictionary["results"] as! [NSDictionary] //using self.movies instead of just movies lets xcode know that we are referring only to movies in this VC.
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //returns # of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if there are movies
        if let movies = movies
        {
            return movies.count //cause you wanna know how many rows of movies to make
        }
        else
        {
            return 0
        }
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        // Do your job, when done:
        refreshControl.endRefreshing()
    }
    
    
    //function that allows you to do the data input
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell //index path tells us where the cell is in the table view. also by using reusable cell identifers, it makes it so that when you scroll off screen, it is recycled. therefore, the computer doesn't have to remember tons of things.
        let movie = movies![indexPath.row] //movies is set as an optional via ? mark so therefore, you need to unwrap it with a ! mark.
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        cell.titleLabel!.text = title
        cell.overviewLabel!.text = overview
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + posterPath)
         cell.posterView.setImageWithURL(imageUrl!) //thanks to cocapod
        
        
        
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
