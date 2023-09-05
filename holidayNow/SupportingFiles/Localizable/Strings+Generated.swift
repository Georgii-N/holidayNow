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
    internal static let `continue` = L10n.tr("Localizable", "congratulation.continue", fallback: "Далее")
    /// Длинное
    internal static let long = L10n.tr("Localizable", "congratulation.long", fallback: "Длинное")
    /// Короткое
    internal static let short = L10n.tr("Localizable", "congratulation.short", fallback: "Короткое")
    /// Выберите тип контента
    internal static let title = L10n.tr("Localizable", "congratulation.title", fallback: "Выберите тип контента")
    /// Шаг 1/3
    internal static let turn = L10n.tr("Localizable", "congratulation.turn", fallback: "Шаг 1/3")
    internal enum Button {
      /// Хокку
      internal static let haiku = L10n.tr("Localizable", "congratulation.button.haiku", fallback: "Хокку")
      /// Стихотворение
      internal static let poetry = L10n.tr("Localizable", "congratulation.button.poetry", fallback: "Стихотворение")
      /// Простое
      internal static let text = L10n.tr("Localizable", "congratulation.button.text", fallback: "Простое")
    }
  }
  internal enum FirstForm {
    /// Имя
    internal static let name = L10n.tr("Localizable", "firstForm.name", fallback: "Имя")
    /// Расскажите подробнее о том, кого хотите поздравить
    internal static let tellAboutPerson = L10n.tr("Localizable", "firstForm.tellAboutPerson", fallback: "Расскажите подробнее о том, кого хотите поздравить")
    /// Шаг 2/3
    internal static let turn = L10n.tr("Localizable", "firstForm.turn", fallback: "Шаг 2/3")
    internal enum Interests {
      /// Добавить своё
      internal static let addMyOwn = L10n.tr("Localizable", "firstForm.interests.addMyOwn", fallback: "Добавить своё")
      /// Животные
      internal static let animals = L10n.tr("Localizable", "firstForm.interests.animals", fallback: "Животные")
      /// Настольные игры
      internal static let boardGames = L10n.tr("Localizable", "firstForm.interests.boardGames", fallback: "Настольные игры")
      /// Готовка
      internal static let cooking = L10n.tr("Localizable", "firstForm.interests.cooking", fallback: "Готовка")
      /// Фильмы
      internal static let movies = L10n.tr("Localizable", "firstForm.interests.movies", fallback: "Фильмы")
      /// Музыка
      internal static let music = L10n.tr("Localizable", "firstForm.interests.music", fallback: "Музыка")
      /// Природа
      internal static let nature = L10n.tr("Localizable", "firstForm.interests.nature", fallback: "Природа")
      /// Программирование
      internal static let programming = L10n.tr("Localizable", "firstForm.interests.programming", fallback: "Программирование")
      /// Спорт
      internal static let sport = L10n.tr("Localizable", "firstForm.interests.sport", fallback: "Спорт")
      /// Вкусная еда
      internal static let tastyFoods = L10n.tr("Localizable", "firstForm.interests.tastyFoods", fallback: "Вкусная еда")
      /// Театр
      internal static let theatre = L10n.tr("Localizable", "firstForm.interests.theatre", fallback: "Театр")
      /// Интересы
      internal static let title = L10n.tr("Localizable", "firstForm.interests.title", fallback: "Интересы")
      /// Путешествия
      internal static let travelling = L10n.tr("Localizable", "firstForm.interests.travelling", fallback: "Путешествия")
      /// Видео игры
      internal static let videoGames = L10n.tr("Localizable", "firstForm.interests.videoGames", fallback: "Видео игры")
    }
  }
  internal enum Onboarding {
    /// Создай своё уникальное праздничное поздравление на базе искусственного интеллекта
    internal static let description = L10n.tr("Localizable", "onboarding.description", fallback: "Создай своё уникальное праздничное поздравление на базе искусственного интеллекта")
    /// Magic Text
    internal static let title = L10n.tr("Localizable", "onboarding.title", fallback: "Magic Text")
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
