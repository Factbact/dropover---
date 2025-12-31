//
//  SettingsWindow.swift
//  FloatingShelf
//

import Cocoa

class SettingsWindowController: NSWindowController {
    
    static let shared = SettingsWindowController()
    private var buttonCheckboxes: [NSButton] = []
    
    private init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 420, height: 560),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = L(.settings)
        window.center()
        window.isReleasedWhenClosed = false
        
        super.init(window: window)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func rebuildUI() {
        window?.contentView?.subviews.forEach { $0.removeFromSuperview() }
        buttonCheckboxes.removeAll()
        window?.title = L(.settings)
        setupUI()
    }
    
    private func setupUI() {
        guard let contentView = window?.contentView else { return }
        contentView.wantsLayer = true
        
        // ScrollView
        let scrollView = NSScrollView(frame: contentView.bounds)
        scrollView.autoresizingMask = [.width, .height]
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        contentView.addSubview(scrollView)
        
        // Document view (flipped for top-to-bottom layout)
        let documentView = FlippedView(frame: NSRect(x: 0, y: 0, width: 400, height: 600))
        scrollView.documentView = documentView
        
        var yPos: CGFloat = 15
        
        // === Language Section ===
        yPos = addSection(to: documentView, yPos: yPos, title: L(.language), height: 50) { container in
            let langPopup = NSPopUpButton(frame: NSRect(x: 15, y: 12, width: 200, height: 25), pullsDown: false)
            for lang in AppLanguage.allCases {
                langPopup.addItem(withTitle: lang.displayName)
            }
            if let index = AppLanguage.allCases.firstIndex(of: LocalizationManager.shared.currentLanguage) {
                langPopup.selectItem(at: index)
            }
            langPopup.target = self
            langPopup.action = #selector(self.languageChanged(_:))
            container.addSubview(langPopup)
        }
        
        // === Auto-Hide Section ===
        yPos = addSection(to: documentView, yPos: yPos, title: L(.behavior), height: 70) { container in
            let checkbox = NSButton(checkboxWithTitle: L(.autoHideWhenEmpty), target: self, action: #selector(self.toggleAutoHide(_:)))
            checkbox.state = SettingsManager.shared.autoHideEnabled ? .on : .off
            checkbox.frame = NSRect(x: 15, y: 35, width: 300, height: 20)
            container.addSubview(checkbox)
            
            let delayLabel = NSTextField(labelWithString: L(.delay))
            delayLabel.frame = NSRect(x: 15, y: 8, width: 50, height: 20)
            container.addSubview(delayLabel)
            
            let delayField = NSTextField()
            delayField.stringValue = String(Int(SettingsManager.shared.autoHideDelay))
            delayField.frame = NSRect(x: 65, y: 8, width: 40, height: 20)
            delayField.target = self
            delayField.action = #selector(self.delayChanged(_:))
            container.addSubview(delayField)
            
            let secLabel = NSTextField(labelWithString: L(.seconds))
            secLabel.frame = NSRect(x: 110, y: 8, width: 30, height: 20)
            container.addSubview(secLabel)
        }
        
        // === Color Section ===
        yPos = addSection(to: documentView, yPos: yPos, title: L(.defaultColor), height: 50) { container in
            let colorPopup = NSPopUpButton(frame: NSRect(x: 15, y: 12, width: 200, height: 25), pullsDown: false)
            let colorKeys: [LocalizedKey] = [.colorBlue, .colorIndigo, .colorPurple, .colorPink, .colorRed, .colorOrange, .colorYellow, .colorGreen, .colorTeal, .colorGray]
            let colors = ["#4A90D9", "#5C6BC0", "#7E57C2", "#EC407A", "#EF5350", "#FF7043", "#FFCA28", "#66BB6A", "#26A69A", "#78909C"]
            for (index, key) in colorKeys.enumerated() {
                colorPopup.addItem(withTitle: L(key))
                if colors[index] == SettingsManager.shared.defaultShelfColor {
                    colorPopup.selectItem(at: index)
                }
            }
            colorPopup.target = self
            colorPopup.action = #selector(self.colorPopupChanged(_:))
            container.addSubview(colorPopup)
        }
        
        // === ZIP Section ===
        yPos = addSection(to: documentView, yPos: yPos, title: L(.zipSaveLocation), height: 50) { container in
            let zipPopup = NSPopUpButton(frame: NSRect(x: 15, y: 12, width: 200, height: 25), pullsDown: false)
            zipPopup.addItems(withTitles: [L(.downloads), L(.desktop), L(.askEachTime)])
            let locations = ["downloads", "desktop", "ask"]
            if let index = locations.firstIndex(of: SettingsManager.shared.zipSaveLocation) {
                zipPopup.selectItem(at: index)
            }
            zipPopup.target = self
            zipPopup.action = #selector(self.zipLocationChanged(_:))
            container.addSubview(zipPopup)
        }
        
        // === Startup Section ===
        yPos = addSection(to: documentView, yPos: yPos, title: L(.startup), height: 45) { container in
            let checkbox = NSButton(checkboxWithTitle: L(.launchAtLogin), target: self, action: #selector(self.toggleLaunchAtLogin(_:)))
            checkbox.state = UserDefaults.standard.bool(forKey: "launchAtLogin") ? .on : .off
            checkbox.frame = NSRect(x: 15, y: 12, width: 200, height: 20)
            container.addSubview(checkbox)
        }
        
        // === Action Bar Section ===
        yPos = addSection(to: documentView, yPos: yPos, title: L(.actionBar), height: 100) { container in
            let buttonKeys: [LocalizedKey] = [.selectAll, .sort, .share, .airdrop, .copy, .paste, .save, .zip, .delete]
            let buttonIds = SettingsManager.allButtonIds
            let visibleButtons = SettingsManager.shared.visibleActionButtons
            
            for (index, key) in buttonKeys.enumerated() {
                let checkbox = NSButton(checkboxWithTitle: L(key), target: self, action: #selector(self.toggleActionButton(_:)))
                checkbox.state = visibleButtons.contains(buttonIds[index]) ? .on : .off
                checkbox.tag = 500 + index
                
                let row = index / 3
                let col = index % 3
                checkbox.frame = NSRect(x: CGFloat(15 + col * 120), y: CGFloat(65 - row * 28), width: 110, height: 20)
                container.addSubview(checkbox)
                self.buttonCheckboxes.append(checkbox)
            }
        }
        
        documentView.frame = NSRect(x: 0, y: 0, width: 400, height: yPos + 20)
    }
    
    private func addSection(to parent: NSView, yPos: CGFloat, title: String, height: CGFloat, content: (NSView) -> Void) -> CGFloat {
        let titleLabel = NSTextField(labelWithString: title)
        titleLabel.font = NSFont.systemFont(ofSize: 13, weight: .semibold)
        titleLabel.textColor = NSColor.secondaryLabelColor
        titleLabel.frame = NSRect(x: 20, y: yPos, width: 200, height: 18)
        parent.addSubview(titleLabel)
        
        let cardView = NSView(frame: NSRect(x: 15, y: yPos + 22, width: 370, height: height))
        cardView.wantsLayer = true
        cardView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        cardView.layer?.cornerRadius = 10
        parent.addSubview(cardView)
        
        content(cardView)
        
        return yPos + 22 + height + 15
    }
    
    // MARK: - Actions
    
    @objc private func languageChanged(_ sender: NSPopUpButton) {
        let index = sender.indexOfSelectedItem
        let languages = AppLanguage.allCases
        if index >= 0 && index < languages.count {
            LocalizationManager.shared.currentLanguage = languages[index]
            rebuildUI()
        }
    }
    
    @objc private func toggleActionButton(_ sender: NSButton) {
        let buttonIds = SettingsManager.allButtonIds
        let index = sender.tag - 500
        guard index >= 0 && index < buttonIds.count else { return }
        
        var visible = SettingsManager.shared.visibleActionButtons
        let buttonId = buttonIds[index]
        
        if sender.state == .on {
            if !visible.contains(buttonId) {
                visible.append(buttonId)
            }
        } else {
            visible.removeAll { $0 == buttonId }
        }
        
        SettingsManager.shared.visibleActionButtons = visible
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
    
    @objc private func toggleLaunchAtLogin(_ sender: NSButton) {
        SettingsManager.shared.launchAtLogin = sender.state == .on
    }
    
    func show() {
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

class FlippedView: NSView {
    override var isFlipped: Bool { return true }
}
