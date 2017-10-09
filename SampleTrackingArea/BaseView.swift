//
//  BaseView.swift
//  SampleTrackingArea
//
//  Created by LoopMac on 2017/10/09.
//  Copyright © 2017年 ikapper. All rights reserved.
//

import Cocoa

class BaseView: NSView {

    // 現在設定中のトラッキングエリアを保持する
    var mouseTrackingArea: NSTrackingArea?
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        updateTrackingArea()
    }
    
    override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        
        // リサイズが行われたらトラッキングエリアを更新
        updateTrackingArea()
    }
    
    func updateTrackingArea() {
        if let ta = mouseTrackingArea {
            if ta.rect == visibleRect {
                // 監視しているエリアサイズに変更がなければ何もしない
                return
            } else {
                // サイズが変わっていたら以前のエリアを削除
                removeTrackingArea(ta)
            }
        }
        
        // 新しいエリアを設定
        // 監視するイベントを指定
        let options: NSTrackingAreaOptions = [NSTrackingAreaOptions.mouseMoved, NSTrackingAreaOptions.activeInKeyWindow]
        mouseTrackingArea = NSTrackingArea(rect: visibleRect, options: options, owner: self, userInfo: nil)
        addTrackingArea(mouseTrackingArea!)
    }
    
    override func mouseMoved(with event: NSEvent) {
        // 何かする
        let location = event.locationInWindow
        let inforect = textField.frame
        
        if inforect.contains(location) {
            textField.stringValue = "Mouse is on the label!"
        } else {
            textField.stringValue = "Mouse location: \(location)"
        }
        
        super.mouseMoved(with: event)
    }
    
}
