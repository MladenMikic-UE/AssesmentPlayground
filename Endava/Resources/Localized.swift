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
  /// Open Article
  internal static let articleDetailOpenArticleTitle = L10n.tr("Localizable", "article_detail_open_article_title", fallback: "Open Article")
  /// Edit RSS Feed
  internal static let editNewObjectHeaderTitle = L10n.tr("Localizable", "edit_new_object_header_title", fallback: "Edit RSS Feed")
  /// Localizable.strings
  ///   Endava
  /// 
  ///   Created by Mladen Mikic on 07.02.2024.
  internal static let mainListNoObjectPlaceholderTitle = L10n.tr("Localizable", "main_list_no_object_placeholder_title", fallback: "No RSS feeds are available. Tap on the '+' button to add your first RSS feed.")
  /// RSS Feeds
  internal static let mainListObjectHeaderTitle = L10n.tr("Localizable", "main_list_object_header_title", fallback: "RSS Feeds")
  /// Articles
  internal static let mainTabArticlesTitle = L10n.tr("Localizable", "main_tab_articles_title", fallback: "Articles")
  /// Favourites
  internal static let mainTabFavouritesTitle = L10n.tr("Localizable", "main_tab_favourites_title", fallback: "Favourites")
  /// All Articles
  internal static let settingsAllArticlesTabTitle = L10n.tr("Localizable", "settings_all_articles_tab_title", fallback: "All Articles")
  /// Disable new articles being fetched for this RSS feed
  internal static let settingsDissableRssFeedArticlesTitle = L10n.tr("Localizable", "settings_dissable_rss_feed_articles_title", fallback: "Disable new articles being fetched for this RSS feed")
  /// Disable push notifications for this RSS feed
  internal static let settingsDissableRssFeedPushNotificationsTitle = L10n.tr("Localizable", "settings_dissable_rss_feed_push_notifications_title", fallback: "Disable push notifications for this RSS feed")
  /// Disable this RSS Feed
  internal static let settingsDissableRssFeedTitle = L10n.tr("Localizable", "settings_dissable_rss_feed_title", fallback: "Disable this RSS Feed")
  /// RSS Feed Settings
  internal static let settingsHeaderTitle = L10n.tr("Localizable", "settings_header_title", fallback: "RSS Feed Settings")
  /// Open all web pages outside of the App (Default Browser)
  internal static let settingsOpenWebPagesTitle = L10n.tr("Localizable", "settings_open_web_pages_title", fallback: "Open all web pages outside of the App (Default Browser)")
  /// RSS Feed
  internal static let settingsRssTitle = L10n.tr("Localizable", "settings_rss_title", fallback: "RSS Feed")
  /// Settings
  internal static let settingsSettingsTabTitle = L10n.tr("Localizable", "settings_settings_tab_title", fallback: "Settings")
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
