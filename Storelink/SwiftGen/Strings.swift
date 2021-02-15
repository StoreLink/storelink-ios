// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  /// Настройки аккаунта
  internal static let accountSettings = Strings.tr("Localizable", "account_settings")
  /// Добавить
  internal static let add = Strings.tr("Localizable", "add")
  /// Продолжить
  internal static let `continue` = Strings.tr("Localizable", "continue")
  /// Введите 4-значный код, отправленный на:
  internal static let fourDigitCode = Strings.tr("Localizable", "four_digit_code")
  /// Вход
  internal static let login = Strings.tr("Localizable", "login")
  /// Вход или регистрация
  internal static let loginOrRegister = Strings.tr("Localizable", "login_or_register")
  /// Войти в кабинет
  internal static let loginToAccount = Strings.tr("Localizable", "login_to_account")
  /// Авторизуйтесь чтобы управлять свойм аккаунтом
  internal static let loginToManageAccount = Strings.tr("Localizable", "login_to_manage_account")
  /// Главная
  internal static let main = Strings.tr("Localizable", "main")
  /// Сообщения
  internal static let messages = Strings.tr("Localizable", "messages")
  /// Уведомления
  internal static let notifications = Strings.tr("Localizable", "notifications")
  /// Пароль
  internal static let password = Strings.tr("Localizable", "password")
  /// Методы оплаты
  internal static let paymentMethods = Strings.tr("Localizable", "payment_methods")
  /// Персональная информация
  internal static let personalInformation = Strings.tr("Localizable", "personal_information")
  /// Номер телефона
  internal static let phoneNumber = Strings.tr("Localizable", "phone_number")
  /// Профиль
  internal static let profile = Strings.tr("Localizable", "profile")
  /// Регистрация
  internal static let signup = Strings.tr("Localizable", "signup")
  /// Хранилище
  internal static let storage = Strings.tr("Localizable", "storage")
  /// Требуется проверка
  internal static let verificationRequired = Strings.tr("Localizable", "verification_required")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
