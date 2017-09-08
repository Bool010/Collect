//
//  WNPermissions.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import AssetsLibrary
import CoreTelephony
import CoreLocation
import UserNotifications
import AddressBook
import Contacts
import EventKit

struct WNPermissions {
    
    /// 相机和麦克风权限
    static func cameraPermissions() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    }
    
    static func isCameraPermissions() -> Bool {
        return cameraPermissions() != .denied
    }
    
    
    /// 相册权限
    static func isPhotoPermissions() -> Bool {
        var result = false
        if #available(iOS 8.0, *) {
            result = PHPhotoLibrary.authorizationStatus() != .denied
        } else {
            result = ALAssetsLibrary.authorizationStatus() != .denied
        }
        return result
    }
    
    /// 联网权限
    static func networkPermissions() -> CTCellularDataRestrictedState {
        if #available(iOS 9.0, *) {
            let cellularData = CTCellularData.init()
            return cellularData.restrictedState
        } else {
            return .restrictedStateUnknown
        }
    }
    
    static func isNetworkPermissions() -> Bool {
        return networkPermissions() != .restricted
    }
    
    
    /// 定位权限
    static func locationPermissions() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    static func isLocationPermissions() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    
    /// 推送权限
    static func isNotificationPermissions() -> Bool {
        
        var result = false
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings(completionHandler: { (setting) in
                result = setting.authorizationStatus != .denied
            })
        } else {
            let setting = UIApplication.shared.currentUserNotificationSettings
            guard let _setting = setting else { return false}
            if _setting.types == .sound ||
               _setting.types == .alert ||
               _setting.types == .badge {
                result = true
            }
        }
        return result
    }
    
    /// 通讯录权限
    static func isAddressBookPermissions() -> Bool {
        
        var result = false
        if #available(iOS 9.0, *) {
            result = CNContactStore.authorizationStatus(for: .contacts) != .denied
        } else {
            result = ABAddressBookGetAuthorizationStatus() != .denied
        }
        return result
    }
    
    
    /// 日历、备忘录权限
    static func isNotePermissions(type: EKEntityType) -> Bool {
        
        return EKEventStore.authorizationStatus(for: type) != .denied
    }
}
