//
//  AppDelegate.swift
//  BeaconClubMember
//
//  Created by Rob Kerr on 5/11/15.
//  Copyright (c) 2015 Mobile Toolworks LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BeaconServiceDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITabBar.appearance().barTintColor = Branding.customColor(.TabBarBackground)
        UITabBar.appearance().tintColor = Branding.customColor(.TabBarStroke)
 
        // setup AWS environment
        let accessKey = "AKIAIAY3AL2YTBMIFJWA"
        let secretKey = "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"
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let defaultServiceConfiguration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = defaultServiceConfiguration
//        AWSS3TransferManager.registerS3TransferManagerWithConfiguration(defaultServiceConfiguration, forKey: "USEastTrasnferManager")
        
        
//            let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
  //          let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
//            AWSS3TransferManager.registerS3TransferManagerWithConfiguration(configuration, forKey: "USWest2S3TransferManager")
//        let S3TransferManager = AWSS3TransferManager(forKey: "USWest2S3TransferManager")
        
//            return true
//        }
        
        
        // start background scanning service
        sharedBeaconService
        sharedBeaconService.addDelegate(self)
        sharedBeaconService.startScanning()
        
        
        
        return true
    }
    
    func foundNewClosestBeacon(beaconId : Int, rssi : Int, proximity : CLProximity, accuracy : Double) {
        Util.log("Found beacon in AppDelegate: \(beaconId)")
    }
    
    func foundBeacon(beaconId : Int, rssi : Int, proximity : CLProximity, accuracy : Double ) {
        Util.log("Found beacon in AppDelegate: \(beaconId)")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

