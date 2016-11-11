//
//  TableViewController.swift
//  projekt2
//
//  Created by alicja on 11/7/16.
//  Copyright © 2016 alicja. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

        var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print(albums.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let album = albums[indexPath.row]
        cell.textLabel?.text = album.artist
        cell.detailTextLabel?.text = album.title

        return cell
    }
    
    @IBAction func unWindToAlbumListWithSender(sender:UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? ViewController, album = sourceViewController.album, deleteIndex:NSIndexPath? = sourceViewController.deleteIndex {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if deleteIndex != nil {
                    albums.removeAtIndex((deleteIndex?.row)!)
                    tableView.deleteRowsAtIndexPaths([deleteIndex!], withRowAnimation: .None)
                }
                else {
                    albums[selectedIndexPath.row] = album
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                }
            }
            else {
                //add new album
                let newIndexPath = NSIndexPath(forRow: albums.count, inSection: 0)
                albums.append(album)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }

    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if let destination = segue.destinationViewController as? ViewController {
                if let cell = sender as? UITableViewCell {
                    let index = tableView.indexPathForCell(cell)
                    let selectedAlbum = albums[(index?.row)!]
                    destination.album = selectedAlbum
                }
            }
        }
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    func loadData(){
        
        var longplays:NSMutableArray = []
        let plistPath = NSBundle.mainBundle().pathForResource("albums", ofType: "plist")
        longplays = NSMutableArray(contentsOfFile: plistPath!)!
        
        for record in longplays {
            let newAlbum = Album(artist: record.valueForKey("artist") as! String,
                                 title: record.valueForKey("title") as! String,
                                 genre: record.valueForKey("genre") as! String,
                                 year: record.valueForKey("date") as! Int,
                                 rating: record.valueForKey("rating") as! Int)
            albums.append(newAlbum!)
        }
    }
    
}
    


