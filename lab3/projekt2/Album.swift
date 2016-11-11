//
//  Album.swift
//  projekt2
//
//  Created by alicja on 11/9/16.
//  Copyright © 2016 alicja. All rights reserved.
//

import Foundation
import UIKit


class Album {
    
    var artist: String
    var title: String
    var genre: String
    var year: Int
    var rating: Int
    
    init?(artist:String, title:String, genre:String, year:Int, rating: Int){
        
        self.artist = artist
        self.title = title
        self.genre = genre
        self.year = year
        self.rating = rating
        
        if self.rating > 5 || self.rating < 0 {
            return nil
        }
    }
}
