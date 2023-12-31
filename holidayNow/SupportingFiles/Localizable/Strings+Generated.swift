// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Congratulation {
    /// Тип поздравления
    internal static let chooseType = L10n.tr("Localizable", "congratulation.chooseType", fallback: "Тип поздравления")
    /// Длинное
    internal static let long = L10n.tr("Localizable", "congratulation.long", fallback: "Длинное")
    /// Количество строк
    internal static let numberOfRows = L10n.tr("Localizable", "congratulation.numberOfRows", fallback: "Количество строк")
    /// Количество предложений
    internal static let sentencesLengh = L10n.tr("Localizable", "congratulation.sentencesLengh", fallback: "Количество предложений")
    /// Короткое
    internal static let short = L10n.tr("Localizable", "congratulation.short", fallback: "Короткое")
    /// Запустить магию
    internal static let startMagic = L10n.tr("Localizable", "congratulation.startMagic", fallback: "Запустить магию")
    /// Выберите тип поздравления и Magic Text начнёт творить волшебство
    internal static let title = L10n.tr("Localizable", "congratulation.title", fallback: "Выберите тип поздравления и Magic Text начнёт творить волшебство")
    /// Шаг 3/3
    internal static let turn = L10n.tr("Localizable", "congratulation.turn", fallback: "Шаг 3/3")
    internal enum Button {
      /// Стихотворение
      internal static let poetry = L10n.tr("Localizable", "congratulation.button.poetry", fallback: "Стихотворение")
      /// Обычное поздравление
      internal static let text = L10n.tr("Localizable", "congratulation.button.text", fallback: "Обычное поздравление")
    }
  }
  internal enum FirstForm {
    /// Далее
    internal static let continueButton = L10n.tr("Localizable", "firstForm.continueButton", fallback: "Далее")
    /// Кого поздравляем
    internal static let name = L10n.tr("Localizable", "firstForm.name", fallback: "Кого поздравляем")
    /// Введите имя
    internal static let namePlaceholder = L10n.tr("Localizable", "firstForm.namePlaceholder", fallback: "Введите имя")
    /// Расскажите кого будем поздравлять
    internal static let title = L10n.tr("Localizable", "firstForm.title", fallback: "Расскажите кого будем поздравлять")
    /// Шаг 1/3
    internal static let turn = L10n.tr("Localizable", "firstForm.turn", fallback: "Шаг 1/3")
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
      /// Больше недоступно
      internal static let noAvailable = L10n.tr("Localizable", "firstForm.interests.noAvailable", fallback: "Больше недоступно")
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
  internal enum GreetingFactory {
    /// с праздником: 
    internal static let holidayText = L10n.tr("Localizable", "greetingFactory.holidayText", fallback: "с праздником: ")
    /// Сделай акцент на интересах человека: 
    internal static let interestsText = L10n.tr("Localizable", "greetingFactory.interestsText", fallback: "Сделай акцент на интересах человека: ")
    /// Поздравление должно быть: 
    internal static let intonationText = L10n.tr("Localizable", "greetingFactory.intonationText", fallback: "Поздравление должно быть: ")
    /// Поздравь на русском языке человека с именем: 
    internal static let nameText = L10n.tr("Localizable", "greetingFactory.nameText", fallback: "Поздравь на русском языке человека с именем: ")
    /// Количество предложений: 
    internal static let sentensesCountText = L10n.tr("Localizable", "greetingFactory.sentensesCountText", fallback: "Количество предложений: ")
    /// обычное
    internal static let stumbText = L10n.tr("Localizable", "greetingFactory.stumbText", fallback: "обычное")
    /// Тип поздравления: 
    internal static let typeText = L10n.tr("Localizable", "greetingFactory.typeText", fallback: "Тип поздравления: ")
  }
  internal enum Onboarding {
    /// Создай своё уникальное праздничное поздравление на базе искусственного интеллекта
    internal static let description = L10n.tr("Localizable", "onboarding.description", fallback: "Создай своё уникальное праздничное поздравление на базе искусственного интеллекта")
    /// Holiday Now
    internal static let title = L10n.tr("Localizable", "onboarding.title", fallback: "Holiday Now")
    internal enum StartButton {
      /// Начать
      internal static let title = L10n.tr("Localizable", "onboarding.startButton.title", fallback: "Начать")
    }
  }
  internal enum ResultScreen {
    /// В Начало
    internal static let goToStart = L10n.tr("Localizable", "resultScreen.goToStart", fallback: "В Начало")
    /// Попробуйте снова
    internal static let repeatButton = L10n.tr("Localizable", "resultScreen.repeatButton", fallback: "Попробуйте снова")
    /// Результаты
    internal static let title = L10n.tr("Localizable", "resultScreen.title", fallback: "Результаты")
    internal enum APIErrorText {
      /// Искуственный интеллект устал и уснул, не может подобрать поздравление. Попробуйте позже!:(
      internal static let var1 = L10n.tr("Localizable", "resultScreen.APIErrorText.var1", fallback: "Искуственный интеллект устал и уснул, не может подобрать поздравление. Попробуйте позже!:(")
    }
    internal enum NetworkErrorText {
      /// Магии не произошло, попробуйте еще раз
      ///  :(
      internal static let var1 = L10n.tr("Localizable", "resultScreen.NetworkErrorText.var1", fallback: "Магии не произошло, попробуйте еще раз\n :(")
    }
    internal enum Waiting {
      /// Ждем вместе с вами
      internal static let title = L10n.tr("Localizable", "resultScreen.Waiting.title", fallback: "Ждем вместе с вами")
    }
    internal enum WaitingText {
      /// Происходит магия Хогвартса...Скоро все будет!
      internal static let var1 = L10n.tr("Localizable", "resultScreen.WaitingText.var1", fallback: "Происходит магия Хогвартса...Скоро все будет!")
      /// Скоро все будет...
      ///  ИИ готовит инструменты
      internal static let var2 = L10n.tr("Localizable", "resultScreen.WaitingText.var2", fallback: "Скоро все будет...\n ИИ готовит инструменты")
      /// Нейросеть уже проснулась...Ждем результата...
      internal static let var3 = L10n.tr("Localizable", "resultScreen.WaitingText.var3", fallback: "Нейросеть уже проснулась...Ждем результата...")
    }
  }
  internal enum SecondForm {
    /// Дерзкое
    internal static let bold = L10n.tr("Localizable", "secondForm.bold", fallback: "Дерзкое")
    /// Далее
    internal static let continueButton = L10n.tr("Localizable", "secondForm.continueButton", fallback: "Далее")
    /// Креативное
    internal static let creative = L10n.tr("Localizable", "secondForm.creative", fallback: "Креативное")
    /// Милое
    internal static let cute = L10n.tr("Localizable", "secondForm.cute", fallback: "Милое")
    /// Весёлое
    internal static let funny = L10n.tr("Localizable", "secondForm.funny", fallback: "Весёлое")
    /// Нежное
    internal static let gentle = L10n.tr("Localizable", "secondForm.gentle", fallback: "Нежное")
    /// Интонация поздравления
    internal static let greetingsIntonation = L10n.tr("Localizable", "secondForm.greetingsIntonation", fallback: "Интонация поздравления")
    /// Название праздника
    internal static let greetingsName = L10n.tr("Localizable", "secondForm.greetingsName", fallback: "Название праздника")
    /// День рождения
    internal static let happyBirthday = L10n.tr("Localizable", "secondForm.happyBirthday", fallback: "День рождения")
    /// Доброе
    internal static let kind = L10n.tr("Localizable", "secondForm.kind", fallback: "Доброе")
    /// 23 февраля
    internal static let mensDay = L10n.tr("Localizable", "secondForm.mensDay", fallback: "23 февраля")
    /// Новый год
    internal static let newYear = L10n.tr("Localizable", "secondForm.newYear", fallback: "Новый год")
    /// Уважительное
    internal static let respectful = L10n.tr("Localizable", "secondForm.respectful", fallback: "Уважительное")
    /// Чувственное
    internal static let sensual = L10n.tr("Localizable", "secondForm.sensual", fallback: "Чувственное")
    /// Расскажите подробнее о празднике
    internal static let title = L10n.tr("Localizable", "secondForm.title", fallback: "Расскажите подробнее о празднике")
    /// Шаг 2/3
    internal static let turn = L10n.tr("Localizable", "secondForm.turn", fallback: "Шаг 2/3")
    /// Остроумное
    internal static let witty = L10n.tr("Localizable", "secondForm.witty", fallback: "Остроумное")
    /// 8 марта
    internal static let womensDay = L10n.tr("Localizable", "secondForm.womensDay", fallback: "8 марта")
  }
  internal enum Success {
    /// Успех! Ваше праздничное поздравление создано
    internal static let result = L10n.tr("Localizable", "success.result", fallback: "Успех! Ваше праздничное поздравление создано")
    internal enum BackToStartButton {
      /// Начать заново
      internal static let title = L10n.tr("Localizable", "success.backToStartButton.title", fallback: "Начать заново")
    }
    internal enum EditButton {
      internal enum Edit {
        /// Редактировать
        internal static let title = L10n.tr("Localizable", "success.editButton.edit.title", fallback: "Редактировать")
      }
    }
    internal enum SaveButton {
      internal enum Save {
        /// Сохранить
        internal static let title = L10n.tr("Localizable", "success.saveButton.save.title", fallback: "Сохранить")
      }
    }
    internal enum ShareButton {
      /// Поделиться
      internal static let title = L10n.tr("Localizable", "success.shareButton.title", fallback: "Поделиться")
    }
  }
  internal enum Warning {
    /// Максимальное количество символов - 20
    internal static let characterLimits = L10n.tr("Localizable", "warning.characterLimits", fallback: "Максимальное количество символов - 20")
    /// Максимальное количество интересов - 
    internal static let optionLimits = L10n.tr("Localizable", "warning.optionLimits", fallback: "Максимальное количество интересов - ")
    /// Некорректный текст
    internal static let wrongWord = L10n.tr("Localizable", "warning.wrongWord", fallback: "Некорректный текст")
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
