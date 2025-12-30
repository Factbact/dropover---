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
        static let defaultShelfColor = "defaultShelfColor"
        static let launchAtLogin = "launchAtLogin"
        static let zipSaveLocation = "zipSaveLocation"
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
    
    // MARK: - Appearance Settings
    
    /// Default shelf color hex (default: blue)
    var defaultShelfColor: String {
        get { defaults.string(forKey: Keys.defaultShelfColor) ?? "#4A90D9" }
        set { defaults.set(newValue, forKey: Keys.defaultShelfColor) }
    }
    
    // MARK: - Startup Settings
    
    /// Launch at login (default: false)
    var launchAtLogin: Bool {
        get { defaults.bool(forKey: Keys.launchAtLogin) }
        set { defaults.set(newValue, forKey: Keys.launchAtLogin) }
    }
    
    // MARK: - ZIP Settings
    
    /// ZIP save location: "downloads", "desktop", or "ask"
    var zipSaveLocation: String {
        get { defaults.string(forKey: Keys.zipSaveLocation) ?? "downloads" }
        set { defaults.set(newValue, forKey: Keys.zipSaveLocation) }
    }
    
    private init() {
        // Register defaults
        defaults.register(defaults: [
            Keys.autoHideEnabled: false,
            Keys.autoHideDelay: 5.0,
            Keys.defaultShelfColor: "#4A90D9",
            Keys.launchAtLogin: false,
            Keys.zipSaveLocation: "downloads"
        ])
    }
}
