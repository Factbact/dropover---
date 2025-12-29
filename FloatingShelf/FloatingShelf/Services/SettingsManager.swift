//
//  SettingsManager.swift
//  FloatingShelf
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Keys
    private enum Keys {
        static let autoHideEnabled = "autoHideEnabled"
        static let autoHideDelay = "autoHideDelay"
    }
    
    // MARK: - Auto-Hide Settings
    
    /// Whether auto-hide is enabled (default: false)
    var autoHideEnabled: Bool {
        get { defaults.bool(forKey: Keys.autoHideEnabled) }
        set { defaults.set(newValue, forKey: Keys.autoHideEnabled) }
    }
    
    /// Auto-hide delay in seconds (default: 5)
    var autoHideDelay: TimeInterval {
        get {
            let value = defaults.double(forKey: Keys.autoHideDelay)
            return value > 0 ? value : 5.0
        }
        set { defaults.set(newValue, forKey: Keys.autoHideDelay) }
    }
    
    private init() {
        // Register defaults
        defaults.register(defaults: [
            Keys.autoHideEnabled: false,
            Keys.autoHideDelay: 5.0
        ])
    }
}
