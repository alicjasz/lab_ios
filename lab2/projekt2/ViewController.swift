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
    var albumsDocPath: String = ""
    var counter:Int = 0

    
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
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBAction func prevButtonPressed(sender: AnyObject) {
        counter -= 1
        if counter == 0 {
            prevButton.enabled = false
        }
        if counter < 0 {
            counter = 0
        }
        if counter < albums.count {
            loadData(counter)
        }
    }
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButtonPressed(sender: AnyObject) {
        counter += 1
        if counter > 0 {
            prevButton.enabled = true
        }
        if counter < albums.count {
            loadData(counter)
        }
        if counter == albums.count {
            addNewRecord()
        }
    }
    @IBOutlet weak var newRecordButton: UIButton!
    @IBAction func newRecordButtonPressed(sender: AnyObject) {
        addNewRecord()
        newRecordButton.enabled = false
    }
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonPressed(sender: AnyObject) {
        addNewData()
    }
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        if albums.count == 1 {
            albums.removeObjectAtIndex(0)
            addNewRecord()
        }
        if counter < albums.count && counter > 0 {
            albums.removeObjectAtIndex(counter)
            counter -= 1
            loadData(counter)
        }
        else if counter == 0 {
            albums.removeObjectAtIndex(0)
            loadData(0)
        }
        else if counter == 1 {
            albums.removeObjectAtIndex(counter)
            loadData(0)
        }
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
    
    func getData() -> NSMutableArray{
        let plistPath = NSBundle.mainBundle().pathForResource("albums", ofType:"plist")
        albums = NSMutableArray(contentsOfFile: plistPath!)!
        return albums
    }
 
    func loadData(cur: Int){
        if cur == 0 {
            prevButton.enabled = false
        }
        
        artistField.text = albums[cur]["artist"] as? String
        albumText.text = albums[cur]["title"] as? String
        genreText.text = albums[cur]["genre"] as? String
        yearText.text = String(albums[cur]["date"]!!)
        ratings.text = String(albums[cur]["rating"]!!)
        stateLabel.text = "Record \(cur + 1) of \(albums.count)"
    }
    
    func addNewData(){
        
        let newRecord = NSDictionary(dictionary:["artist":artistField.text ?? "",
            "title":albumText.text ?? "",
            "date": yearText.text ?? "",
            "genre":genreText.text ?? "",
            "rating":ratings.text ?? String(0)])
 
        if counter == albums.count {
            albums.addObject(newRecord)
            prevButton.enabled = true
            saveButton.enabled = false
            newRecordButton.enabled = true
        }
        
        stateLabel.text = "Record \(counter + 1) of \(albums.count)"
        
        if counter >= 0 && counter < albums.count {
            albums.replaceObjectAtIndex(counter, withObject:newRecord)
            saveButton.enabled = false
        }
    }
    
    func addNewRecord(){
        counter = albums.count
        artistField.text = ""
        albumText.text = ""
        genreText.text = ""
        yearText.text = ""
        ratings.text = String(0)
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
        getData()
        loadData(0)
        prevButton.enabled = false
        saveButton.enabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
