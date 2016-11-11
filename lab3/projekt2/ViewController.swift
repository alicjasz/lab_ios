//
//  ViewController.swift
//  projekt2
//
//  Created by alicja on 10/29/16.
//  Copyright © 2016 alicja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var albums: NSMutableArray = []
    var counter:Int = 0
    var album: Album?
    var deleteIndex: NSIndexPath?
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var albumText: UITextField!
    @IBOutlet weak var genreText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var ratings: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func stepperPressed(sender: UIStepper) {
        if sender.value > 5 {
            sender.value = 0
        }
        if sender.value < 0 {
            sender.value = 5
        }
        saveButton.enabled = true
        ratings.text = Int(sender.value).description
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if saveButton === sender {
            let artist = artistField.text ?? ""
            let title = albumText.text ?? ""
            let genre = genreText.text ?? ""
            let year = Int(yearText.text ?? "0")
            let rating = Int(ratings.text ?? "0")
        
            album = Album(artist: artist, title: title, genre: genre, year: year!, rating: rating!)
        }
        
        if deleteButton === sender {
            let sourceViewController = segue.destinationViewController as! TableViewController
            deleteIndex = sourceViewController.tableView.indexPathForSelectedRow
        }
    }
    
    func getData() -> NSMutableArray{
        let plistPath = NSBundle.mainBundle().pathForResource("albums", ofType:"plist")
        albums = NSMutableArray(contentsOfFile: plistPath!)!
        return albums
    }
 
    func loadData(cur: Int){

        artistField.text = albums[cur]["artist"] as? String
        albumText.text = albums[cur]["title"] as? String
        genreText.text = albums[cur]["genre"] as? String
        yearText.text = String(albums[cur]["date"]!!)
        ratings.text = String(albums[cur]["rating"]!!)
    }
    
    func addNewData(){
        
        let newRecord = NSDictionary(dictionary:["artist":artistField.text ?? "",
            "title":albumText.text ?? "",
            "date": yearText.text ?? "",
            "genre":genreText.text ?? "",
            "rating":ratings.text ?? String(0)])
        
        if counter == albums.count {
            albums.addObject(newRecord)
            saveButton.enabled = false
        }
                
        if counter >= 0 && counter < albums.count {
            albums.replaceObjectAtIndex(counter, withObject:newRecord)
            saveButton.enabled = false
        }
    }

    @IBAction func changeArtistText(sender: UITextField) {
        saveButton.enabled = true
    }
    @IBAction func changeAlbumText(sender: UITextField) {
        saveButton.enabled = true
    }
    
    @IBAction func changeGenreText(sender: UITextField) {
        saveButton.enabled = true
    }
    
    @IBAction func changeYearText(sender: UITextField) {
        saveButton.enabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albums = getData()
        if let album = album {
            artistField.text = album.artist
            albumText.text = album.title
            genreText.text = album.genre
            yearText.text = String(album.year)
            ratings.text = String(album.rating)
            
        }
        saveButton.enabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
