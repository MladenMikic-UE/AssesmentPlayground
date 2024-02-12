//
//  FullScreenWKWebView.swift
//  Shared
//
//  Created by Mladen Mikic on 12.02.2024.
//

import UIKit
import SwiftUI
import WebKit

public class FullScreenWKWebView: WKWebView {
    
    public override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
