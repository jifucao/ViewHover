//
//  NSView+Hover.swift
//  ViewHover
//
//  Created by Jifu Cao on 2022/3/25.
//  Copyright (c) 2022 Jifu. All rights reserved.
//

import AppKit

public extension NSView {
  enum HoverEffect {
    case cornerRadius(CGFloat)
    case background(color: NSColor)
    case transform(CATransform3D)
  }
}

public extension NSView {
  private static var _hoverLayer: Int = 0
  private var _hoverLayer: CALayer? {
    get { objc_getAssociatedObject(self, &Self._hoverLayer) as? CALayer }
    set { objc_setAssociatedObject(self, &Self._hoverLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
  
  func onHover(option: MouseTrackOption = [], handler: @escaping (Bool) -> Void) {
    mouseTracker.subscribeMouseMoveEvent(option: option) { event in
      handler(event == .entered)
    }
  }
  
  
  func hoverEffects(_ effects: HoverEffect...){
    mouseTracker.subscribeMouseMoveEvent(option: []) {[unowned self] event in
      switch event {
      case .exited:
        effects.forEach { effect in
          switch effect {
          case .transform:
            self.layer?.transform =  CATransform3DIdentity
          case .background:
            self._setHoverColor(.clear)
          case .cornerRadius:
            self._hoverLayer?.cornerRadius = 0
          }
        }
      case .entered:
        wantsLayer = true
        effects.forEach { effect in
          switch effect {
          case .transform(let t):
            self.layer?.transform =  t
          case .background(let color):
            self._setHoverColor(color)
          case .cornerRadius(let r):
            self._hoverLayer?.cornerRadius = r
          }
        }
      }
    }
  }
  
  private func _setHoverColor(_ color: NSColor) {
    if let lay = _hoverLayer {
      lay.backgroundColor = color.cgColor
    } else {
      let l = CALayer()
      l.frame = bounds
      l.backgroundColor = color.cgColor
      layer?.addSublayer(l)
      _hoverLayer = l
    }
  }
}
