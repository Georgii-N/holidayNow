// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Congratulation {
    /// Длина поздравления
    internal static let congratulationLengh = L10n.tr("Localizable", "congratulation.congratulationLengh", fallback: "Длина поздравления")
    /// Далее
    internal static let contitnue = L10n.tr("Localizable", "congratulation.contitnue", fallback: "Далее")
    /// Длинное
    internal static let long = L10n.tr("Localizable", "congratulation.long", fallback: "Длинное")
    /// Короткое
    internal static let short = L10n.tr("Localizable", "congratulation.short", fallback: "Короткое")
    /// Выберите тип контента
    internal static let title = L10n.tr("Localizable", "congratulation.title", fallback: "Выберите тип контента")
    internal enum Button {
      /// Хокку
      internal static let haiku = L10n.tr("Localizable", "congratulation.button.haiku", fallback: "Хокку")
      /// Стихотворение
      internal static let poetry = L10n.tr("Localizable", "congratulation.button.poetry", fallback: "Стихотворение")
      /// Простое
      internal static let text = L10n.tr("Localizable", "congratulation.button.text", fallback: "Простое")
    }
  }
  internal enum Onboarding {
    /// Найдите повод для радости каждый день и создайте своё уникальное праздничное поздравление
    internal static let description = L10n.tr("Localizable", "onboarding.description", fallback: "Найдите повод для радости каждый день и создайте своё уникальное праздничное поздравление")
    /// Holiday Now
    internal static let title = L10n.tr("Localizable", "onboarding.title", fallback: "Holiday Now")
    internal enum StartButton {
      /// Начать
      internal static let title = L10n.tr("Localizable", "onboarding.startButton.title", fallback: "Начать")
    }
  }
  internal enum Success {
    /// Успех! Ваше праздничное поздравление создано
    internal static let result = L10n.tr("Localizable", "success.result", fallback: "Успех! Ваше праздничное поздравление создано")
    internal enum BackToStartButton {
      /// Начать заново
      internal static let title = L10n.tr("Localizable", "success.backToStartButton.title", fallback: "Начать заново")
    }
    internal enum ShareButton {
      /// Поделиться
      internal static let title = L10n.tr("Localizable", "success.shareButton.title", fallback: "Поделиться")
    }
  }
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
