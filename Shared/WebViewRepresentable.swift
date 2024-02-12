//
//  WebViewRepresentable.swift
//  Shared
//
//  Created by Mladen Mikic on 11.02.2024.
//
import SwiftUI
import WebKit

public struct WebViewRepresentable: UIViewRepresentable {
    
    public var url: URL?
    public var hTMLString: String?
    
    /// Uses the raw `url` value for `URLRequest` creation and loading.
    public init(url: URL) {
        self.url = url
    }
    
    /// Creates a `URL` from the provided `string`.
    /// Attempts to validate the `URL` creation with `addingPercentEncoding`.
    public init?(string: String) {
        guard let validString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        self.url = URL(string: validString)
    }
    
    /// Uses the raw `hTMLString` value for `loadHTMLString`.
    public init(hTMLString: String) {
        self.hTMLString = hTMLString
    }
 
    public func makeUIView(context: Context) -> WKWebView {
        return FullScreenWKWebView()
    }
 
    public func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        } else if let hTMLString = hTMLString {
            webView.loadHTMLString(hTMLString, baseURL: Bundle.main.bundleURL)
        }
    }
}

class FullScreenWKWebView: WKWebView {
    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
