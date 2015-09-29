//****************************************************************************************
//
//          File:           EventsViewController.swift
//          Project:        BeaconClub Proof-of-Concept
//          Description:    Screen that shows upcoming events
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************
import UIKit

class EventsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Branding.setBrandingForView(self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
