// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Create New
  internal static let addNewObjectFinishTitle = L10n.tr("Localizable", "add_new_object_finish_title", fallback: "Create New")
  /// New RSS Feed
  internal static let addNewObjectHeaderTitle = L10n.tr("Localizable", "add_new_object_header_title", fallback: "New RSS Feed")
  /// Create New
  internal static let addNewObjectPickerTitle = L10n.tr("Localizable", "add_new_object_picker_title", fallback: "Create New")
  /// Enter a RSS feed Title.
  internal static let addNewObjectTitlePlaceholderDescription = L10n.tr("Localizable", "add_new_object_title_placeholder_description", fallback: "Enter a RSS feed Title.")
  /// Enter a RSS feed URL. Example: https://example.com/feed
  internal static let addNewObjectUrlPlaceholderDescription = L10n.tr("Localizable", "add_new_object_url_placeholder_description", fallback: "Enter a RSS feed URL. Example: https://example.com/feed")
  /// Title: 
  internal static let addNewObjectUrlTitle = L10n.tr("Localizable", "add_new_object_url_title", fallback: "Title: ")
  /// Select New RSS Feed
  internal static let addNewSelectedObjectFinishTitle = L10n.tr("Localizable", "add_new_selected_object_finish_title", fallback: "Select New RSS Feed")
  /// Select New RSS Feed
  internal static let addNewSelectedObjectHeaderTitle = L10n.tr("Localizable", "add_new_selected_object_header_title", fallback: "Select New RSS Feed")
  /// Select New
  internal static let addNewSelectedObjectPickerTitle = L10n.tr("Localizable", "add_new_selected_object_picker_title", fallback: "Select New")
  /// Edit RSS Feed
  internal static let editNewObjectHeaderTitle = L10n.tr("Localizable", "edit_new_object_header_title", fallback: "Edit RSS Feed")
  /// Localizable.strings
  ///   Endava
  /// 
  ///   Created by Mladen Mikic on 07.02.2024.
  internal static let mainListNoObjectPlaceholderTitle = L10n.tr("Localizable", "main_list_no_object_placeholder_title", fallback: "No RSS feeds are available. Tap on the '+' button to add your first RSS feed.")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
