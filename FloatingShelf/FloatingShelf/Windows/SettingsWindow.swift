//
//  SettingsWindow.swift
//  FloatingShelf
//

import Cocoa

class SettingsWindowController: NSWindowController {
    
    static let shared = SettingsWindowController()
    
    private init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 320, height: 200),
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
        let titleLabel = NSTextField(labelWithString: "Auto-Hide Settings")
        titleLabel.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Enable checkbox
        let enableCheckbox = NSButton(checkboxWithTitle: "Enable auto-hide for empty shelves", target: self, action: #selector(toggleAutoHide(_:)))
        enableCheckbox.state = SettingsManager.shared.autoHideEnabled ? .on : .off
        enableCheckbox.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(enableCheckbox)
        
        // Delay label
        let delayLabel = NSTextField(labelWithString: "Close after:")
        delayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(delayLabel)
        
        // Delay stepper + text field
        let delayField = NSTextField()
        delayField.stringValue = String(Int(SettingsManager.shared.autoHideDelay))
        delayField.isEditable = true
        delayField.target = self
        delayField.action = #selector(delayChanged(_:))
        delayField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(delayField)
        
        // Seconds label
        let secondsLabel = NSTextField(labelWithString: "seconds")
        secondsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondsLabel)
        
        // Stepper
        let stepper = NSStepper()
        stepper.minValue = 1
        stepper.maxValue = 60
        stepper.integerValue = Int(SettingsManager.shared.autoHideDelay)
        stepper.target = self
        stepper.action = #selector(stepperChanged(_:))
        stepper.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stepper)
        
        // Store references
        delayField.tag = 100
        stepper.tag = 101
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            enableCheckbox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            enableCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            delayLabel.topAnchor.constraint(equalTo: enableCheckbox.bottomAnchor, constant: 20),
            delayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            delayField.centerYAnchor.constraint(equalTo: delayLabel.centerYAnchor),
            delayField.leadingAnchor.constraint(equalTo: delayLabel.trailingAnchor, constant: 10),
            delayField.widthAnchor.constraint(equalToConstant: 50),
            
            stepper.centerYAnchor.constraint(equalTo: delayLabel.centerYAnchor),
            stepper.leadingAnchor.constraint(equalTo: delayField.trailingAnchor, constant: 5),
            
            secondsLabel.centerYAnchor.constraint(equalTo: delayLabel.centerYAnchor),
            secondsLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: 5),
        ])
        
        window?.contentView = contentView
    }
    
    @objc private func toggleAutoHide(_ sender: NSButton) {
        SettingsManager.shared.autoHideEnabled = sender.state == .on
    }
    
    @objc private func delayChanged(_ sender: NSTextField) {
        if let value = Double(sender.stringValue), value >= 1 && value <= 60 {
            SettingsManager.shared.autoHideDelay = value
            if let stepper = window?.contentView?.viewWithTag(101) as? NSStepper {
                stepper.integerValue = Int(value)
            }
        }
    }
    
    @objc private func stepperChanged(_ sender: NSStepper) {
        SettingsManager.shared.autoHideDelay = Double(sender.integerValue)
        if let field = window?.contentView?.viewWithTag(100) as? NSTextField {
            field.stringValue = String(sender.integerValue)
        }
    }
    
    func show() {
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
