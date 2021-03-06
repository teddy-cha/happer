//
//  Backup.swift
//  Happer
//
//  Created by Theodore Cha on 2017. 8. 22..
//  Copyright © 2017년 Theodore Cha. All rights reserved.
//

import UIKit
import Zip

class Backup: NSObject {
    
    static func createBackup() {
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let myurl = docsurl.appendingPathComponent("default.realm")
            let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
            let zipFilePath = documentsDirectory.appendingPathComponent("data.zip")
            try Zip.zipFiles(paths: [myurl], zipFilePath: zipFilePath, password: "password", progress: { (progress) -> () in
                CloudDataManager.sharedInstance.copyFileToCloud()
                print(progress)
            })
        } catch {
            print("Something went wrong")
        }
    }
    
    class func unzipBackup()  {
        do {
            
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let myurl = docsurl.appendingPathComponent("data.zip")
            let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
            try Zip.unzipFile(myurl, destination: documentsDirectory, overwrite: true, password: "password", progress: { (progress) -> () in
                CloudDataManager.sharedInstance.copyFileToLocal()
                print(progress)
            }) // Unzip
        } catch {
            print("Something went wrong")
        }
        
    }
    
}
