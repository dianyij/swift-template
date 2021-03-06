//
//  LocationMngr.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: CLLocationManager, CLLocationManagerDelegate {

    static let shared: LocationManager = LocationManager()
    fileprivate var m_callback: ((CLLocation?) -> Void)?

    private override init() {
        super.init()
        self.delegate = self
        self.requestWhenInUseAuthorization()
    }

    fileprivate var bStartFindLocation: Bool = false {
        didSet {
            if bStartFindLocation {
                self.startUpdatingLocation()
            } else {
                self.stopUpdatingLocation()
            }
        }
    }

    func getCurrent(location: @escaping (CLLocation?) -> Void) {
        checkPermission(enabled: { [unowned self] () in
            self.requestWhenInUseAuthorization()
            self.m_callback = location
            self.bStartFindLocation = true
        }, askToOpen: { () in
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Permission is required", message: "Location Permission is Requird", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            }
            location(nil)
        })
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, true == bStartFindLocation else { return }
        bStartFindLocation = false
        if CLLocationManager.locationServicesEnabled() == false {
            requestWhenInUseAuthorization()
        }
        m_callback?(location)

        m_callback = nil

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            requestWhenInUseAuthorization()
        case .restricted, .denied:
            bStartFindLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            bStartFindLocation = true
        default:
            requestWhenInUseAuthorization()
        }
    }

    func checkPermission(enabled: @escaping () -> Void = { }, askToOpen: @escaping () -> Void = { }) {
        if CLLocationManager.locationServicesEnabled() == false {
            requestWhenInUseAuthorization()
            return
        }
        if CLLocationManager.locationServicesEnabled() {
            requestWhenInUseAuthorization()
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.requestWhenInUseAuthorization()
                askToOpen()
            case .authorizedAlways, .authorizedWhenInUse:
                enabled()
            default:
                requestWhenInUseAuthorization()
            }
        }
    }
}
