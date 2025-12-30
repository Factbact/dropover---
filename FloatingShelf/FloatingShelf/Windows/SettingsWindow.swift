//
//  SettingsWindow.swift
//  FloatingShelf
//

import Cocoa

class SettingsWindowController: NSWindowController {
    
    static let shared = SettingsWindowController()
    
    private init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 340),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = "Settings"
        window.center()
        
        super.init(window: window)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let contentView = NSView(frame: window!.contentView!.bounds)
        contentView.wantsLayer = true
        
        // Title
        let titleLabel = NSTextField(labelWithString: "Settings")
        titleLabel.font = NSFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // --- Auto-Hide Section ---
        let autoHideHeader = NSTextField(labelWithString: "Auto-Hide")
        autoHideHeader.font = NSFont.systemFont(ofSize: 14, weight: .semibold)
        autoHideHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(autoHideHeader)
        
        let enableCheckbox = NSButton(checkboxWithTitle: "Enable auto-hide for empty shelves", target: self, action: #selector(toggleAutoHide(_:)))
        enableCheckbox.state = SettingsManager.shared.autoHideEnabled ? .on : .off
        enableCheckbox.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(enableCheckbox)
        
        let delayLabel = NSTextField(labelWithString: "Close after:")
        delayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(delayLabel)
        
        let delayField = NSTextField()
        delayField.stringValue = String(Int(SettingsManager.shared.autoHideDelay))
        delayField.isEditable = true
        delayField.target = self
        delayField.action = #selector(delayChanged(_:))
        delayField.translatesAutoresizingMaskIntoConstraints = false
        delayField.tag = 100
        contentView.addSubview(delayField)
        
        let secondsLabel = NSTextField(labelWithString: "seconds")
        secondsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondsLabel)
        
        // --- Appearance Section ---
        let appearanceHeader = NSTextField(labelWithString: "Appearance")
        appearanceHeader.font = NSFont.systemFont(ofSize: 14, weight: .semibold)
        appearanceHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(appearanceHeader)
        
        let colorLabel = NSTextField(labelWithString: "Default shelf color:")
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorLabel)
        
        let colorPopup = NSPopUpButton()
        colorPopup.translatesAutoresizingMaskIntoConstraints = false
        let colors = ["#4A90D9", "#5C6BC0", "#7E57C2", "#EC407A", "#EF5350", "#FF7043", "#FFCA28", "#66BB6A", "#26A69A", "#78909C"]
        let colorNames = ["Blue", "Indigo", "Purple", "Pink", "Red", "Orange", "Yellow", "Green", "Teal", "Gray"]
        for (index, name) in colorNames.enumerated() {
            colorPopup.addItem(withTitle: name)
            if colors[index] == SettingsManager.shared.defaultShelfColor {
                colorPopup.selectItem(at: index)
            }
        }
        colorPopup.target = self
        colorPopup.action = #selector(colorPopupChanged(_:))
        colorPopup.tag = 200
        contentView.addSubview(colorPopup)
        
        // --- ZIP Section ---
        let zipHeader = NSTextField(labelWithString: "ZIP Compression")
        zipHeader.font = NSFont.systemFont(ofSize: 14, weight: .semibold)
        zipHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(zipHeader)
        
        let zipLocationLabel = NSTextField(labelWithString: "Save ZIP to:")
        zipLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(zipLocationLabel)
        
        let zipPopup = NSPopUpButton()
        zipPopup.translatesAutoresizingMaskIntoConstraints = false
        zipPopup.addItems(withTitles: ["Downloads", "Desktop", "Ask each time"])
        let locations = ["downloads", "desktop", "ask"]
        if let index = locations.firstIndex(of: SettingsManager.shared.zipSaveLocation) {
            zipPopup.selectItem(at: index)
        }
        zipPopup.target = self
        zipPopup.action = #selector(zipLocationChanged(_:))
        zipPopup.tag = 300
        contentView.addSubview(zipPopup)
        
        // Layout
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            autoHideHeader.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            autoHideHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            enableCheckbox.topAnchor.constraint(equalTo: autoHideHeader.bottomAnchor, constant: 8),
            enableCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            delayLabel.topAnchor.constraint(equalTo: enableCheckbox.bottomAnchor, constant: 8),
            delayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            delayField.centerYAnchor.constraint(equalTo: delayLabel.centerYAnchor),
            delayField.leadingAnchor.constraint(equalTo: delayLabel.trailingAnchor, constant: 8),
            delayField.widthAnchor.constraint(equalToConstant: 50),
            
            secondsLabel.centerYAnchor.constraint(equalTo: delayLabel.centerYAnchor),
            secondsLabel.leadingAnchor.constraint(equalTo: delayField.trailingAnchor, constant: 8),
            
            appearanceHeader.topAnchor.constraint(equalTo: delayLabel.bottomAnchor, constant: 20),
            appearanceHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            colorLabel.topAnchor.constraint(equalTo: appearanceHeader.bottomAnchor, constant: 8),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            colorPopup.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor),
            colorPopup.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: 8),
            colorPopup.widthAnchor.constraint(equalToConstant: 120),
            
            zipHeader.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            zipHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            zipLocationLabel.topAnchor.constraint(equalTo: zipHeader.bottomAnchor, constant: 8),
            zipLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            zipPopup.centerYAnchor.constraint(equalTo: zipLocationLabel.centerYAnchor),
            zipPopup.leadingAnchor.constraint(equalTo: zipLocationLabel.trailingAnchor, constant: 8),
            zipPopup.widthAnchor.constraint(equalToConstant: 140),
        ])
        
        window?.contentView = contentView
    }
    
    @objc private func toggleAutoHide(_ sender: NSButton) {
        SettingsManager.shared.autoHideEnabled = sender.state == .on
    }
    
    @objc private func delayChanged(_ sender: NSTextField) {
        if let value = Double(sender.stringValue), value >= 1 && value <= 60 {
            SettingsManager.shared.autoHideDelay = value
        }
    }
    
    @objc private func colorPopupChanged(_ sender: NSPopUpButton) {
        let colors = ["#4A90D9", "#5C6BC0", "#7E57C2", "#EC407A", "#EF5350", "#FF7043", "#FFCA28", "#66BB6A", "#26A69A", "#78909C"]
        let index = sender.indexOfSelectedItem
        if index >= 0 && index < colors.count {
            SettingsManager.shared.defaultShelfColor = colors[index]
        }
    }
    
    @objc private func zipLocationChanged(_ sender: NSPopUpButton) {
        let locations = ["downloads", "desktop", "ask"]
        let index = sender.indexOfSelectedItem
        if index >= 0 && index < locations.count {
            SettingsManager.shared.zipSaveLocation = locations[index]
        }
    }
    
    func show() {
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
