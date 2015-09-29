//****************************************************************************************
//
//          File:           SpecialsTileFlowLayout.swift
//          Project:        BeaconClub Proof-of-Concept
//          Description:    Object to provide the layout for the collection view
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************
import UIKit

class SpecialsTileFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        self.itemSize = CGSizeMake(175, 165)
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 30
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
