//****************************************************************************************
//
//          File:           MyAccountController.swift
//          Project:        BeaconClub Proof-of-Concept
//          Description:    Screen that shows the member's account data
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************
import UIKit

class MyAccountViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Branding.setBrandingForView(self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

