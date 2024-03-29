// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Date: 
  internal static let addNewObjectDateTitle = L10n.tr("Localizable", "add_new_object_date_title", fallback: "Date: ")
  /// Description: 
  internal static let addNewObjectDescriptionTitle = L10n.tr("Localizable", "add_new_object_Description_title", fallback: "Description: ")
  /// Schedule
  internal static let addNewObjectFinishTitle = L10n.tr("Localizable", "add_new_object_finish_title", fallback: "Schedule")
  /// New Appointment
  internal static let addNewObjectHeaderTitle = L10n.tr("Localizable", "add_new_object_header_title", fallback: "New Appointment")
  /// Location: 
  internal static let addNewObjectLocationTitle = L10n.tr("Localizable", "add_new_object_location_title", fallback: "Location: ")
  /// Reschedule
  internal static let editNewObjectFinisTitle = L10n.tr("Localizable", "edit_new_object_finis_title", fallback: "Reschedule")
  /// Edit Appointment
  internal static let editNewObjectHeaderTitle = L10n.tr("Localizable", "edit_new_object_header_title", fallback: "Edit Appointment")
  /// Localizable.strings
  ///   Movemedical
  /// 
  ///   Created by Mladen Mikic on 07.02.2024.
  internal static let mainListNoObjectPlaceholderTitle = L10n.tr("Localizable", "main_list_no_object_placeholder_title", fallback: "No Appointments are available. Tap the '+' button to create your first appointment.")
  /// Appointments
  internal static let mainListObjectHeaderTitle = L10n.tr("Localizable", "main_list_object_header_title", fallback: "Appointments")
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
