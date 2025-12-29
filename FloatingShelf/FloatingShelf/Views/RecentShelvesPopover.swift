//
//  RecentShelvesPopover.swift
//  FloatingShelf
//

import Cocoa

class RecentShelvesPopover: NSViewController {
    
    weak var appDelegate: AppDelegate?
    private var shelves: [Shelf] = []
    private let scrollView = NSScrollView()
    private let stackView = NSStackView()
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 280, height: 300))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadShelves()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        // Title
        let titleLabel = NSTextField(labelWithString: "Recent Shelves")
        titleLabel.font = NSFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .labelColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Stack view for shelf items
        stackView.orientation = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Scroll view
        scrollView.documentView = stackView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func loadShelves() {
        shelves = ItemStore.shared.fetchAllShelves()
        
        // Clear existing items
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if shelves.isEmpty {
            let emptyLabel = NSTextField(labelWithString: "No recent shelves")
            emptyLabel.textColor = .secondaryLabelColor
            emptyLabel.alignment = .center
            stackView.addArrangedSubview(emptyLabel)
        } else {
            for shelf in shelves.prefix(5) {
                let itemView = createShelfItemView(shelf)
                stackView.addArrangedSubview(itemView)
            }
        }
    }
    
    private func createShelfItemView(_ shelf: Shelf) -> NSView {
        let container = NSView()
        container.wantsLayer = true
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Hover effect
        let trackingArea = NSTrackingArea(
            rect: .zero,
            options: [.mouseEnteredAndExited, .activeInKeyWindow, .inVisibleRect],
            owner: container,
            userInfo: ["shelfId": shelf.id]
        )
        container.addTrackingArea(trackingArea)
        
        // Thumbnail stack (horizontal, shows up to 3 items)
        let thumbnailStack = NSStackView()
        thumbnailStack.orientation = .horizontal
        thumbnailStack.spacing = 4
        thumbnailStack.translatesAutoresizingMaskIntoConstraints = false
        
        let items = ItemStore.shared.fetchItems(for: shelf.id)
        let displayItems = items.prefix(3)
        
        for item in displayItems {
            let imageView = NSImageView()
            imageView.wantsLayer = true
            imageView.layer?.cornerRadius = 4
            imageView.layer?.masksToBounds = true
            imageView.imageScaling = .scaleProportionallyUpOrDown
            
            if let thumbnailPath = item.thumbnailPath,
               let thumbnailDir = try? FileManager.default.thumbnailsDirectory() {
                let thumbnailURL = thumbnailDir.appendingPathComponent(thumbnailPath)
                imageView.image = NSImage(contentsOf: thumbnailURL)
            } else {
                imageView.image = NSWorkspace.shared.icon(for: .item)
            }
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            thumbnailStack.addArrangedSubview(imageView)
        }
        
        // Name and count label
        let textStack = NSStackView()
        textStack.orientation = .vertical
        textStack.alignment = .leading
        textStack.spacing = 2
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = NSTextField(labelWithString: shelf.name)
        nameLabel.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        nameLabel.textColor = .labelColor
        nameLabel.lineBreakMode = .byTruncatingTail
        
        let countLabel = NSTextField(labelWithString: "\(items.count) items")
        countLabel.font = NSFont.systemFont(ofSize: 10)
        countLabel.textColor = .secondaryLabelColor
        
        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(countLabel)
        
        container.addSubview(thumbnailStack)
        container.addSubview(textStack)
        
        // Click gesture
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(shelfItemClicked(_:)))
        container.addGestureRecognizer(clickGesture)
        container.setValue(shelf.id, forKey: "shelfId")
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 56),
            
            thumbnailStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            thumbnailStack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            textStack.leadingAnchor.constraint(equalTo: thumbnailStack.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            textStack.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        return container
    }
    
    @objc private func shelfItemClicked(_ gesture: NSClickGestureRecognizer) {
        guard let container = gesture.view,
              let shelfId = container.value(forKey: "shelfId") as? UUID else { return }
        
        appDelegate?.openShelf(shelfId)
        dismiss(nil)
    }
}

// Custom view for hover effect
class ShelfItemContainer: NSView {
    var shelfId: UUID?
    
    override func mouseEntered(with event: NSEvent) {
        layer?.backgroundColor = NSColor.selectedContentBackgroundColor.withAlphaComponent(0.3).cgColor
    }
    
    override func mouseExited(with event: NSEvent) {
        layer?.backgroundColor = .clear
    }
}
