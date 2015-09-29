//****************************************************************************************
//
//          File:           Special.swift
//          Project:        BeaconClub Proof-of-Concept
//          Description:    Model for special at the club
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************
import Foundation
import UIKit

class Special {
    var id: String?
    var title : String?
    var area : Int?
    var sortOrder : Int?
    var imageFilename : String?
    var image : UIImage?
    
    init(id: String?, title : String?, area : Int?, sortOrder : Int?, imageFilename : String?) {
        self.id = id
        self.sortOrder = sortOrder
        self.title = title
        self.area = area
        self.imageFilename = imageFilename
    }
}