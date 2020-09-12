// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
  #endif
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let key = ImageAsset(name: "Key")
  internal static let shoppingCart = ImageAsset(name: "Shopping-cart")
  internal static let wallet = ImageAsset(name: "Wallet")
  internal static let arrow = ImageAsset(name: "arrow")
  internal static let arrowSetting = ImageAsset(name: "arrow_setting")
  internal static let avatarDefault = ImageAsset(name: "avatar_default")
  internal static let avatarLogin = ImageAsset(name: "avatar_login")
  internal static let back = ImageAsset(name: "back")
  internal static let bottom = ImageAsset(name: "bottom")
  internal static let clearCache = ImageAsset(name: "clear_cache")
  internal static let createNew = ImageAsset(name: "create_new")
  internal static let edit = ImageAsset(name: "edit")
  internal static let jiaoyu = ImageAsset(name: "jiaoyu")
  internal static let jingxuan = ImageAsset(name: "jingxuan")
  internal static let jobList = ImageAsset(name: "job_list")
  internal static let jobVo = ImageAsset(name: "job_vo")
  internal static let kong = ImageAsset(name: "kong")
  internal static let location = ImageAsset(name: "location")
  internal static let loginCurrent = ImageAsset(name: "login_current")
  internal static let logout = ImageAsset(name: "logout")
  internal static let numberFlag = ImageAsset(name: "number_flag")
  internal static let numberValid = ImageAsset(name: "number_valid")
  internal static let `protocol` = ImageAsset(name: "protocol")
  internal static let server = ImageAsset(name: "server")
  internal static let setting = ImageAsset(name: "setting")
  internal static let studying = ImageAsset(name: "studying")
  internal static let tag = ImageAsset(name: "tag")
  internal static let texting = ImageAsset(name: "texting")
  internal static let validateCorrect = ImageAsset(name: "validate_correct")
  internal static let validateWrong = ImageAsset(name: "validate_wrong")
  internal static let versionUpdate = ImageAsset(name: "version_update")
  internal static let working = ImageAsset(name: "working")
  internal static let xiala = ImageAsset(name: "xiala")

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
  ]
  internal static let allImages: [ImageAsset] = [
    key,
    shoppingCart,
    wallet,
    arrow,
    arrowSetting,
    avatarDefault,
    avatarLogin,
    back,
    bottom,
    clearCache,
    createNew,
    edit,
    jiaoyu,
    jingxuan,
    jobList,
    jobVo,
    kong,
    location,
    loginCurrent,
    logout,
    numberFlag,
    numberValid,
    `protocol`,
    server,
    setting,
    studying,
    tag,
    texting,
    validateCorrect,
    validateWrong,
    versionUpdate,
    working,
    xiala,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX) || os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.name, bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
  #endif
}

private final class BundleToken {}
