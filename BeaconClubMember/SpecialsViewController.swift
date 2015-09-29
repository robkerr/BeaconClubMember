//****************************************************************************************
//
//          File:           SpecialsViewController.swift
//          Project:        BeaconClub Proof-of-Concept
//          Description:    Screen that shows specials within the club
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************
import UIKit

class SpecialsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, BeaconServiceDelegate {
    @IBOutlet weak var areaSegments: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var debugOutput: UILabel!
    

    var tileFlowLayout : SpecialsTileFlowLayout? = nil   // layout collection view with image tiles
    var allSpecials : [Special] = [Special]()            // all specials from web service
    var relevantSpecials : [Special] = [Special]()       // specials relevant to user location
    
    var selectedArea : Int = 0  // default to all
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerNib(UINib(nibName: "SpecialsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpecialCell")
        
        Branding.setBrandingForView(self.view)
        
        areaSegments.tintColor = Branding.customColor(BrandingColor.TextColor)
        noDataLabel.textColor = Branding.customColor(BrandingColor.TextColor)
    }
    
    //*****************************************************************************************
    //
    //             Function: loadData
    //          Description: Load the collection view with the specials that make sense
    //
    //*****************************************************************************************
    func loadData() {
        relevantSpecials.removeAll(keepCapacity: false)

        if self.selectedArea == 0 || self.selectedArea == 1 {   // bar
            relevantSpecials.append(Special(id: "1", title: "Craft Beers", area: 1, sortOrder: 5, imageFilename: "Craft Beers.jpg"))
            relevantSpecials.append(Special(id: "1", title: "Whiskey Drinks", area: 1, sortOrder: 5, imageFilename: "Whiskey Drinks.jpg"))
        }

        if self.selectedArea == 0 || self.selectedArea == 2 {  // restaurant
            relevantSpecials.append(Special(id: "2", title: "Steak Toscano", area: 2, sortOrder: 3, imageFilename: "Steak Toscano.jpg"))
            relevantSpecials.append(Special(id: "3", title: "Herb-Grilled Salmon", area: 2, sortOrder: 1, imageFilename: "Herb-Grilled Salmon.jpg"))
            relevantSpecials.append(Special(id: "4", title: "Bruschetta Caprese", area: 2, sortOrder: 2, imageFilename: "Bruschetta Caprese.jpg"))
        }

        if self.selectedArea == 0 || self.selectedArea == 3 {   // pool
            relevantSpecials.append(Special(id: "5", title: "Grilled Italian Sausage", area: 3, sortOrder: 4, imageFilename: "Grilled Italian Sausage.jpg"))
            relevantSpecials.append(Special(id: "6", title: "Berry Bianco Spritzer", area: 3, sortOrder: 6, imageFilename: "Berry Bianco Spritzer.jpg"))
            relevantSpecials.append(Special(id: "7", title: "Frozen Margaritas", area: 3, sortOrder: 7, imageFilename: "Frozen Margaritas.jpg"))
            relevantSpecials.append(Special(id: "8", title: "Pink Lemonade", area: 3, sortOrder: 8, imageFilename: "Pink Lemonade.jpg"))
            relevantSpecials.append(Special(id: "9", title: "Roscato Berry Cocktail", area: 3, sortOrder: 9 , imageFilename: "Roscato Berry Cocktail.jpg"))
        }
        
        relevantSpecials.sort({$0.sortOrder < $1.sortOrder })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //*****************************************************************************************
    //
    //             Function: viewWillAppear
    //          Description: Prepare objects and set the collection view layout
    //
    //*****************************************************************************************
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        // Set the layout for the colleciton view, and reset the selection of bike to nil
        self.tileFlowLayout = SpecialsTileFlowLayout()
        
        // become the beacon discovery delegate
        sharedBeaconService.addDelegate(self)
        sharedBeaconService.startScanning()
    }

    //*****************************************************************************************
    //
    //             Function: viewWillAppear
    //          Description: Remove self from the set of BLE delegates
    //
    //*****************************************************************************************
    override func viewWillDisappear(animated: Bool) {
        sharedBeaconService.removeDelegate(self)
    }
    
    //*****************************************************************************************
    //
    //             Function: foundNewClosestBeacon
    //          Description: The "Closest beacon" determination has changed in the BLE scanner
    //
    //*****************************************************************************************
    func foundNewClosestBeacon(beaconId : Int, rssi : Int, proximity : CLProximity, accuracy : Double) {
        
        debugOutput.text = "\(beaconId), RSSI=\(rssi), prox=\(proximity.rawValue), acc=\(accuracy)"
        
        switch beaconId {
        case 56366 :
            self.selectedArea = 1
            break
        case 56684 :
            self.selectedArea = 2
            break
        case 22217 :
            self.selectedArea = 3
            break
        default :
            self.selectedArea = 0
            break
        }
        
        self.areaSegments.selectedSegmentIndex = self.selectedArea
        reloadCollectionViewData()
    }

    // unused delegate called on all beacon observations
    func foundBeacon(beaconId : Int, rssi : Int, proximity : CLProximity, accuracy : Double ) {
    }
    
    
    //*****************************************************************************************
    //
    //             Function: areaSegmentChanged
    //          Description: User manually changing the area to view specials for
    //
    //*****************************************************************************************
    @IBAction func areaSegmentChanged(sender: AnyObject) {
        self.selectedArea = self.areaSegments.selectedSegmentIndex
        reloadCollectionViewData()
    }
    
    //*****************************************************************************************
    //
    //             Function: reloadCollectionViewData
    //          Description: Fire a reload of the collection view
    //
    //*****************************************************************************************
    func reloadCollectionViewData() {
        loadData()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.collectionView.reloadData()
            self.noDataLabel.hidden = self.relevantSpecials.count > 0
        })
        
    }
    
    //*****************************************************************************************
    //
    //             Function: changeLayout
    //          Description: Prepare objects just before the view will appear
    //
    //*****************************************************************************************
    func changeLayout() {
        var newLayout : UICollectionViewFlowLayout? = tileFlowLayout
        self.collectionView.reloadData()
        
        self.collectionView!.performBatchUpdates({ () -> Void in
            self.collectionView!.setCollectionViewLayout(newLayout!, animated: true)
            self.collectionView!.collectionViewLayout.invalidateLayout()
            }, completion: { (finished: Bool) -> Void in
        })
    }
 
    
    // MARK: UICollectionViewDataSource
    
    //*****************************************************************************************
    //
    //             Function: numberOfSectionsInCollectionView
    //          Description: Return the number of sections the collection view is divided into
    //                          for this app there is only one section
    //
    //*****************************************************************************************
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //*****************************************************************************************
    //
    //             Function: numberOfItemsInSection
    //          Description: Return the number of items in the specified section
    //
    //*****************************************************************************************
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.relevantSpecials.count
    }
    
    //*****************************************************************************************
    //
    //             Function: cellForItemAtIndexPath
    //          Description: Prepare an individual item for display
    //
    //*****************************************************************************************
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            
            let reuseIdentifier = "SpecialCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SpecialsCollectionViewCell
            
            // Configure the cell
            let specials = self.relevantSpecials[indexPath.row]
            
            cell.itemLabel.text = specials.title
            cell.backgroundRect.backgroundColor = Branding.customColor(BrandingColor.ButtonBackground)
            
            
            // If the special has a filename, download it and dispay it
            if let fileName = specials.imageFilename {
                // specify destination of image
                let tempFileName = NSProcessInfo.processInfo().globallyUniqueString
                let downloadFilePath = NSTemporaryDirectory().stringByAppendingPathComponent(tempFileName)
                let downloadingFileURL = NSURL(fileURLWithPath: downloadFilePath)
                
                // specify source of image
                var transferManager = AWSS3TransferManager.defaultS3TransferManager()
                let downloadRequest = AWSS3TransferManagerDownloadRequest()
                downloadRequest.bucket = "beaconclub"
                downloadRequest.key = fileName
                downloadRequest.downloadingFileURL = downloadingFileURL
                
                let task = transferManager.download(downloadRequest)
                
                task.continueWithBlock { (task) -> AnyObject! in
                    // read in the disk data
                    if let data = NSFileManager.defaultManager().contentsAtPath(downloadFilePath) {
                        // create an image
                        let img = UIImage(data: data)
                        
                        // delete the temporary file
                        NSFileManager.defaultManager().removeItemAtPath(downloadFilePath, error: nil)
                        
                        // set the image to the collection view
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cell.itemImage.image = img
                        })
                    }
                    
                    return nil
                }
            }
            
            return cell
    }
    
    
    //*****************************************************************************************
    //
    //             Function: didSelectItemAtIndexPath
    //          Description: User has tapped on one of the tiles in the collection view
    //
    //*****************************************************************************************
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        Util.log(__FUNCTION__)
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
