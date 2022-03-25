//
//  ViewController.swift
//  ViewHover
//
//  Created by Jifu on 03/25/2022.
//  Copyright (c) 2022 Jifu. All rights reserved.
//

import Cocoa
import ViewHover

class ViewController: NSViewController {
  
  @IBOutlet weak var hoverView: NSView! {
    didSet {
      hoverView.setBackgroundColor(.white)
      hoverView.layer?.cornerRadius = 10
      hoverView.hoverEffects(.background(color: .red),
                             .cornerRadius(10))
    }
  }
  
  @IBOutlet weak var hoverImageView: NSImageView! {
    didSet {
      hoverImageView.image = NSImage.init(named: .computer)
      hoverImageView.onHover {[unowned hoverImageView] hover in
        if hover {
          hoverImageView?.setFrameSize(.init(width: 64, height: 64))
        } else {
          hoverImageView?.setFrameSize(.init(width: 32, height: 32))
        }
      }
    }
  }
  
  @IBOutlet weak var hoverLabel: NSTextField! {
    didSet {
      hoverLabel.stringValue = "Hove Label"
      hoverLabel.hoverEffects(.background(color: .init(white: 0, alpha: 0.2)),
                              .cornerRadius(4)
      )
    }
  }
  
  @IBOutlet weak var hoverButton: NSButton! {
    didSet {
      hoverButton.stringValue = "Hove me"
      hoverButton.hoverEffects(.transform(CATransform3DRotate(CATransform3DIdentity, -CGFloat.pi/2, 0, 0, 1)))
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension NSView {
  func setBackgroundColor(_ color: NSColor) {
    wantsLayer = true
    layer?.backgroundColor = color.cgColor
  }
}
