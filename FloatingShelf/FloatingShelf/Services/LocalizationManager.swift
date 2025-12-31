//
//  LocalizationManager.swift
//  FloatingShelf
//

import Foundation

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case japanese = "ja"
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .japanese: return "日本語"
        }
    }
}

class LocalizationManager {
    static let shared = LocalizationManager()
    
    private init() {}
    
    var currentLanguage: AppLanguage {
        get {
            if let code = UserDefaults.standard.string(forKey: "appLanguage"),
               let lang = AppLanguage(rawValue: code) {
                return lang
            }
            // Default to system language
            let systemLang = Locale.current.languageCode ?? "en"
            return systemLang.starts(with: "ja") ? .japanese : .english
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "appLanguage")
        }
    }
    
    // MARK: - Localized Strings
    
    func string(_ key: LocalizedKey) -> String {
        return currentLanguage == .japanese ? key.ja : key.en
    }
}

// MARK: - Localized Keys

enum LocalizedKey {
    // Settings Window
    case settings
    case behavior
    case autoHideWhenEmpty
    case delay
    case seconds
    case defaultColor
    case zipSaveLocation
    case downloads
    case desktop
    case askEachTime
    case startup
    case launchAtLogin
    case actionBar
    case language
    
    // Color Names
    case colorBlue, colorIndigo, colorPurple, colorPink, colorRed
    case colorOrange, colorYellow, colorGreen, colorTeal, colorGray
    
    // Action Bar Buttons
    case selectAll, sort, share, airdrop, copy, paste, save, zip, delete
    
    // Menu
    case newShelf
    case recentShelves
    case quit

    var en: String {
        switch self {
        case .settings: return "Settings"
        case .behavior: return "Behavior"
        case .autoHideWhenEmpty: return "Auto-hide when empty"
        case .delay: return "Delay:"
        case .seconds: return "sec"
        case .defaultColor: return "Default Color"
        case .zipSaveLocation: return "ZIP Save Location"
        case .downloads: return "Downloads"
        case .desktop: return "Desktop"
        case .askEachTime: return "Ask Each Time"
        case .startup: return "Startup"
        case .launchAtLogin: return "Launch at Login"
        case .actionBar: return "Action Bar"
        case .language: return "Language"
        case .colorBlue: return "Blue"
        case .colorIndigo: return "Indigo"
        case .colorPurple: return "Purple"
        case .colorPink: return "Pink"
        case .colorRed: return "Red"
        case .colorOrange: return "Orange"
        case .colorYellow: return "Yellow"
        case .colorGreen: return "Green"
        case .colorTeal: return "Teal"
        case .colorGray: return "Gray"
        case .selectAll: return "Select All"
        case .sort: return "Sort"
        case .share: return "Share"
        case .airdrop: return "AirDrop"
        case .copy: return "Copy"
        case .paste: return "Paste"
        case .save: return "Save"
        case .zip: return "ZIP"
        case .delete: return "Delete"
        case .newShelf: return "New Shelf"
        case .recentShelves: return "Recent Shelves..."
        case .quit: return "Quit FloatingShelf"
        }
    }
    
    var ja: String {
        switch self {
        case .settings: return "設定"
        case .behavior: return "動作"
        case .autoHideWhenEmpty: return "アイテムがない時に自動で非表示"
        case .delay: return "遅延:"
        case .seconds: return "秒"
        case .defaultColor: return "デフォルトカラー"
        case .zipSaveLocation: return "ZIP保存先"
        case .downloads: return "ダウンロード"
        case .desktop: return "デスクトップ"
        case .askEachTime: return "毎回確認"
        case .startup: return "起動"
        case .launchAtLogin: return "ログイン時に起動"
        case .actionBar: return "アクションバー"
        case .language: return "言語"
        case .colorBlue: return "青"
        case .colorIndigo: return "インディゴ"
        case .colorPurple: return "紫"
        case .colorPink: return "ピンク"
        case .colorRed: return "赤"
        case .colorOrange: return "オレンジ"
        case .colorYellow: return "黄"
        case .colorGreen: return "緑"
        case .colorTeal: return "ティール"
        case .colorGray: return "グレー"
        case .selectAll: return "全選択"
        case .sort: return "並替"
        case .share: return "共有"
        case .airdrop: return "AirDrop"
        case .copy: return "コピー"
        case .paste: return "ペースト"
        case .save: return "保存"
        case .zip: return "ZIP"
        case .delete: return "削除"
        case .newShelf: return "新規シェルフ"
        case .recentShelves: return "最近のシェルフ..."
        case .quit: return "終了"
        }
    }
}

// Convenience function
func L(_ key: LocalizedKey) -> String {
    return LocalizationManager.shared.string(key)
}
