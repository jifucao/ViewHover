//
//  MouseTrackable.swift
//
//  Created by Jifu on 2022/1/20.
//  Copyright (c) 2022 Jifu. All rights reserved.

import AppKit

public enum MouseMoveEvent {
  case exited, entered
}

// MARK: -
public struct  MouseTrackOption: OptionSet {
  public var rawValue: Int = 0
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public static let downAsExit = MouseTrackOption(rawValue: 1)
}

// MARK: -
public protocol MouseTrackable {
  func subscribeMouseMoveEvent(option: MouseTrackOption, observer: @escaping (MouseMoveEvent) -> Void)
}

// MARK: -
public protocol MouseTrackCompatible {
  var mouseTracker: MouseTrackable { get }
}

// MARK: -
public class MouseTracker: NSView, MouseTrackable {
  private var trackAreas: NSTrackingArea?
  public typealias MouseMoveEventObserver = (MouseMoveEvent) -> Void
  private var observer: MouseMoveEventObserver?
  private var option: MouseTrackOption = []
  private var event: MouseMoveEvent = .exited {
    didSet {
      observer?(event)
    }
  }
  
  private func createTrackingArea() {
    let opts: NSTrackingArea.Options = [.mouseEnteredAndExited, .inVisibleRect, .activeInActiveApp]
    trackAreas = NSTrackingArea.init(rect: self.bounds, options: opts, owner: self, userInfo: nil)
    self.addTrackingArea(trackAreas!)
    if let point = self.window?.mouseLocationOutsideOfEventStream {
      let location = self.convert(point, from: nil)
      if NSPointInRect(location, self.bounds) {
        self.mouseEntered(with: NSEvent.init())
      } else {
        self.mouseExited(with: .init())
      }
    }
  }
  
  public override func updateTrackingAreas() {
    if let area = self.trackAreas {
      self.removeTrackingArea(area)
    }
    self.createTrackingArea()
    super.updateTrackingAreas()
  }
  
  public override func mouseExited(with event: NSEvent) {
    self.event = .exited
  }
  
  public override func mouseEntered(with event: NSEvent) {
    self.event = .entered
  }
  
  public override func mouseDown(with event: NSEvent) {
    super.mouseDown(with: event)
    guard option.contains(.downAsExit) else { return }
    self.event = .exited
  }
  
  public func subscribeMouseMoveEvent(option: MouseTrackOption, observer: @escaping (MouseMoveEvent) -> Void) {
    self.option = option
    self.observer = observer
  }
  
}

private var mouseTrackerIndex: Int = 0
// MARK: -
extension MouseTrackCompatible where Self: NSView {
  public var mouseTracker: MouseTrackable {
    let tracker: MouseTracker? = objc_getAssociatedObject(self, &mouseTrackerIndex) as? MouseTracker
    guard let tracker = tracker else {
      let t = MouseTracker()
      self.addSubview(t)
      t.frame = self.bounds
      t.autoresizingMask = [.width, .height]
      objc_setAssociatedObject(self, &mouseTrackerIndex, t, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return t
    }
    return tracker
  }
}

extension NSView: MouseTrackCompatible {}

