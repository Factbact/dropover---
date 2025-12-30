//
//  ActionBarView.swift
//  FloatingShelf
//

import Cocoa

protocol ActionBarDelegate: AnyObject {
    func actionBarDidRequestShare(_ actionBar: ActionBarView)
    func actionBarDidRequestAirDrop(_ actionBar: ActionBarView)
    func actionBarDidRequestCopy(_ actionBar: ActionBarView)
    func actionBarDidRequestPaste(_ actionBar: ActionBarView)
    func actionBarDidRequestSave(_ actionBar: ActionBarView)
    func actionBarDidRequestDelete(_ actionBar: ActionBarView)
    func actionBarDidRequestZip(_ actionBar: ActionBarView)
    func actionBarDidRequestSelectAll(_ actionBar: ActionBarView)
}

class ActionBarView: NSView {
    
    weak var delegate: ActionBarDelegate?
    
    private(set) var shareButton: NSButton!
    private var airDropButton: NSButton!
    private var copyButton: NSButton!
    private var pasteButton: NSButton!
    private var saveButton: NSButton!
    private var deleteButton: NSButton!
    private var zipButton: NSButton!
    private var selectAllButton: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.withAlphaComponent(0.6).cgColor
        layer?.cornerRadius = 10
        
        shareButton = createIconButton(icon: "square.and.arrow.up", 
                                       tooltip: "Share",
                                       action: #selector(shareAction))
        
        airDropButton = createIconButton(icon: "airplane",
                                         tooltip: "AirDrop",
                                         action: #selector(airDropAction))
        
        copyButton = createIconButton(icon: "doc.on.doc",
                                      tooltip: "Copy",
                                      action: #selector(copyAction))
        
        pasteButton = createIconButton(icon: "doc.on.clipboard",
                                       tooltip: "Paste",
                                       action: #selector(pasteAction))
        
        saveButton = createIconButton(icon: "folder",
                                      tooltip: "Save to...",
                                      action: #selector(saveAction))
        
        deleteButton = createIconButton(icon: "trash",
                                        tooltip: "Delete",
                                        action: #selector(deleteAction))
        
        zipButton = createIconButton(icon: "archivebox",
                                     tooltip: "Create ZIP",
                                     action: #selector(zipAction))
        
        selectAllButton = createIconButton(icon: "checkmark.circle",
                                           tooltip: "Select All",
                                           action: #selector(selectAllAction))
        
        // Stack view for compact button layout
        let stackView = NSStackView(views: [selectAllButton, shareButton, airDropButton, copyButton, pasteButton, saveButton, zipButton, deleteButton])
        stackView.orientation = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        
        setEnabled(false)
    }
    
    private func createIconButton(icon: String, tooltip: String, action: Selector) -> NSButton {
        let button = NSButton()
        button.bezelStyle = .regularSquare
        button.isBordered = false
        button.setButtonType(.momentaryPushIn)
        button.toolTip = tooltip
        
        if let image = NSImage(systemSymbolName: icon, accessibilityDescription: tooltip) {
            button.image = image
            button.imagePosition = .imageOnly
            button.imageScaling = .scaleProportionallyUpOrDown
        }
        
        button.target = self
        button.action = action
        
        return button
    }
    
    func setEnabled(_ enabled: Bool) {
        shareButton.isEnabled = enabled
        airDropButton.isEnabled = enabled
        copyButton.isEnabled = enabled
        saveButton.isEnabled = enabled
        deleteButton.isEnabled = enabled
        zipButton.isEnabled = enabled
        // Paste is always enabled
        pasteButton.isEnabled = true
    }
    
    // MARK: - Actions
    
    @objc private func shareAction() {
        delegate?.actionBarDidRequestShare(self)
    }
    
    @objc private func airDropAction() {
        delegate?.actionBarDidRequestAirDrop(self)
    }
    
    @objc private func copyAction() {
        delegate?.actionBarDidRequestCopy(self)
    }
    
    @objc private func pasteAction() {
        delegate?.actionBarDidRequestPaste(self)
    }
    
    @objc private func saveAction() {
        delegate?.actionBarDidRequestSave(self)
    }
    
    @objc private func deleteAction() {
        delegate?.actionBarDidRequestDelete(self)
    }
    
    @objc private func zipAction() {
        delegate?.actionBarDidRequestZip(self)
    }
    
    @objc private func selectAllAction() {
        delegate?.actionBarDidRequestSelectAll(self)
    }
}
