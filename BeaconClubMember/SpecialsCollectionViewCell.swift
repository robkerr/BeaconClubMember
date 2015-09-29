//****************************************************************************************
//
//          File:           SpecialsCollectionViewCell.swift
//          Project:        BeaconClub Proof-of-Concept
//          Description:    Encapsulates a single tile cell in a collectoon view
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************

import UIKit

class SpecialsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundRect: CVBgRectView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
}
