//
//  BeaconManager.swift
//  BeaconClubMember
//
//  Created by Rob Kerr on 5/11/15.
//  Copyright (c) 2015 Mobile Toolworks LLC. All rights reserved.
//

import Foundation

let sharedBeaconService = BeaconService();

protocol BeaconServiceDelegate  {
    func foundBeacon(beaconId : Int, rssi : Int, proximity : CLProximity, accuracy : Double )
    func foundNewClosestBeacon(beaconId : Int, rssi : Int, proximity : CLProximity, accuracy : Double)
}

class BeaconService : NSObject, ESTBeaconManagerDelegate {
    
    var delegates = Set<NSObject>()
    
    var beaconManager : ESTBeaconManager?
    var beaconRegion : CLBeaconRegion?
    
    var lastClosestBeacon : Int = 0
    
    override init() {
        Util.log("Initializing BeaconService")
        
        super.init()
        
        self.beaconManager = ESTBeaconManager()
        
        if let mgr = self.beaconManager {
            
            mgr.delegate = self
            self.beaconRegion = CLBeaconRegion(
                proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"),
                identifier: "beaconclub")
        }
    }
    
    func addDelegate(newDelegate : NSObject) {
        if !delegates.contains(newDelegate) {
            delegates.insert(newDelegate)
        }
    }
    
    func removeDelegate(del : NSObject) {
        if delegates.contains(del) {
            delegates.remove(del)
        }
    }

    func startScanning() {
        if let mgr = self.beaconManager {
            self.lastClosestBeacon = 0
            mgr.requestAlwaysAuthorization()
            mgr.startRangingBeaconsInRegion(self.beaconRegion)
        }
    }
    
    func stopScanning() {
        if let mgr = self.beaconManager {
            mgr.stopRangingBeaconsInRegion(self.beaconRegion)
        }
    }

    // MARK: Estimote iBeacon API
    func beaconManager(manager: AnyObject!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {

        if beacons == nil {
            return
        }
        if beacons.count == 0 {
            return
        }

        // notify delegate of all beacons found
        if self.delegates.count > 0 {
            for var i = 0 ; i < beacons.count ; ++i {
                if let beacon = beacons[i] as? CLBeacon {
                    let beaconMinor = beacon.minor.integerValue
                    let rssi = beacon.rssi
                    let proximity = beacon.proximity
                    let accuracy = beacon.accuracy as Double

                    for del in self.delegates {
                        let d = del as! BeaconServiceDelegate
                        d.foundBeacon(beaconMinor, rssi: rssi, proximity: proximity, accuracy: accuracy)
                    }
                    
                    if i == 0 {
                        if rssi != 0 &&
                            (proximity == CLProximity.Immediate /*|| proximity == CLProximity.Near*/)
                              /*&& (accuracy < 4 && accuracy >= 0.0)*/ {
                            if self.lastClosestBeacon != beaconMinor {
                                self.lastClosestBeacon = beaconMinor
                                for del in self.delegates {
                                    let d = del as! BeaconServiceDelegate
                                    d.foundNewClosestBeacon(beaconMinor, rssi: rssi, proximity: proximity, accuracy: accuracy)
                                }
                            }
                        }
                    }
                }
            } // for
        } // if delegate
    }
}