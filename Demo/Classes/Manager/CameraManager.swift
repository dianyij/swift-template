//
//  CameraManager.swift
//  Demo
//
//  Created by Dianyi Jiang on 7/10/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class CameraManager {

    static let shared: CameraManager = CameraManager()

    func checkPermission(for: AVMediaType = .video, completion: @escaping (Bool) -> Void) {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch authorizationStatus {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: completion)
        default:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: completion)
        }
    }
}
