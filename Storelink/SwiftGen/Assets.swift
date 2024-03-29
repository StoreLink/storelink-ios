// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Assets {
  internal static let coloredBox = ImageAsset(name: "colored_box")
  internal static let coloredStorage = ImageAsset(name: "colored_storage")
  internal static let back = ImageAsset(name: "back")
  internal static let clock = ImageAsset(name: "clock")
  internal static let close = ImageAsset(name: "close")
  internal static let count = ImageAsset(name: "count")
  internal static let downArrow = ImageAsset(name: "down_arrow")
  internal static let eye = ImageAsset(name: "eye")
  internal static let eyeInvisible = ImageAsset(name: "eye_invisible")
  internal static let filter = ImageAsset(name: "filter")
  internal static let heart = ImageAsset(name: "heart")
  internal static let heartOutline = ImageAsset(name: "heart_outline")
  internal static let item = ImageAsset(name: "item")
  internal static let location = ImageAsset(name: "location")
  internal static let logo = ImageAsset(name: "logo")
  internal static let map = ImageAsset(name: "map")
  internal static let size = ImageAsset(name: "size")
  internal static let storage = ImageAsset(name: "storage")
  internal static let launchImage = ImageAsset(name: "launch_image")
  internal static let launchTitleImage = ImageAsset(name: "launch_title_image")
  internal static let notification = ImageAsset(name: "notification")
  internal static let paymentCard = ImageAsset(name: "payment_card")
  internal static let person = ImageAsset(name: "person")
  internal static let personInfo = ImageAsset(name: "person_info")
  internal static let rightArrow = ImageAsset(name: "right_arrow")
  internal static let tabAdd = ImageAsset(name: "tab_add")
  internal static let tabCalculator = ImageAsset(name: "tab_calculator")
  internal static let tabMain = ImageAsset(name: "tab_main")
  internal static let tabProfile = ImageAsset(name: "tab_profile")
  internal static let tabStorage = ImageAsset(name: "tab_storage")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
