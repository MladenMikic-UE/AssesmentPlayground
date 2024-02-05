//
//  UserDefaults+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import Foundation
import Combine

/// We need this for ios13 because @AppStorage only avalaible in ios14?
/// https://www.avanderlee.com/swift/property-wrappers/
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

/// This is a list of all the static vars are being used as a some point in the app to store color themes, or onboarding status etc
extension UserDefaults {

    // MARK: - UI.
    @UserDefault(key: "currentTheme", defaultValue: "endava")
    static var currentTheme: String

    @UserDefault(key: "presentedWelcomeScreen", defaultValue: false)
    static var presentedWelcomeScreen: Bool
    
    static func restartAllValues() {
        currentTheme = "white"
    }
}
