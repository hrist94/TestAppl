//
//  InstantPanGestureRecognizer.swift
//  TestAppl
//
//  Created by Kirill Khristenko on 29.08.2022.
//
import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
