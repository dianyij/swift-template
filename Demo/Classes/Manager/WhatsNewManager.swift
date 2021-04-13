//
//  WhatsNewManager.swift
//  Demo
//
//  Created by djiang on 6/12/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import WhatsNewKit

typealias WhatsNewBlock = (WhatsNew, WhatsNewConfiguration, KeyValueWhatsNewVersionStore?)
typealias WhatsNewConfiguration = WhatsNewViewController.Configuration

class WhatsNewManager: NSObject {
    
    static let shared = WhatsNewManager()
    
    func whatsNew(trackVersion track: Bool = true) -> WhatsNewBlock {
        return (items(), configuration(), track ? versionStore() : nil)
    }
    
    private func items() -> WhatsNew {
        let whatsNew = WhatsNew(
            title: R.string.localization.whatsNewTitle(),
            items: [
                WhatsNew.Item(title: R.string.localization.whatsNewTitle(),
                              subtitle: R.string.localization.whatsNewSubtitle(),
                              image: R.image.add())
            ]
        )
        return whatsNew
    }
    
    private func configuration() -> WhatsNewViewController.Configuration {
        var configuration = WhatsNewViewController.Configuration(
            detailButton: .init(title: R.string.localization.whatsNewTitle1(),
                                action: .website(url: Konfigs.App.baseURL)),
            completionButton: .init(stringLiteral: R.string.localization.whatsNewTitle2())
        )
        
        configuration.itemsView.layout = .centered
        configuration.itemsView.imageSize = .original
        configuration.apply(animation: .slideRight)
        
        configuration.backgroundColor = .blue
        return configuration
    }
    
    private func versionStore() -> KeyValueWhatsNewVersionStore {
        let versionStore = KeyValueWhatsNewVersionStore(keyValueable: UserDefaults.standard, prefixIdentifier: "Konfigs.App.bundleIdentifier")
        return versionStore
    }
}
