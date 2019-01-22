# Change Log
All notable changes to this project will be documented in this file.
`SKLocalizable ` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases
- `1.0.x` Releases - [1.0.1](#101) | [1.0.2](#102) | [1.0.3](#103) | [1.0.4](#104)


## [1.0.4](https://github.com/steelkiwi/SKLocalizable/releases/tag/1.0.4)
Released on 2019-01-22

#### Added
- Unit tests
- `identifier` argument for `Bundle.init(languageCode:)`

#### Updated
- `String` - key-detection regex for parameters


## [1.0.3](https://github.com/steelkiwi/SKLocalizable/releases/tag/1.0.3)
Released on 2019-01-10

#### Added
- `UITabBarItem` title localization support by [Zinuk](https://github.com/zinukArtem)
- `UIBarButtonItem` title localization support

#### Updated
- Reverted arguments detection logic - now required arguments are parsing from localized value instead of just using passed arguments
- Fixed Demo app language change code


## [1.0.2](https://github.com/steelkiwi/SKLocalizable/releases/tag/1.0.2)
Released on 2018-11-01.

#### Added
- `UIViewController` title localization support

#### Updated
- Replaced core key-handling logic into `NSObject`. This allowed to localize any `NSObject` subclass, instead of prev `UIView`
- removed `public` modifier from localized components, so their localization can be overrided in subclass now


## [1.0.1](https://github.com/steelkiwi/SKLocalizable/releases/tag/1.0.1)
Released on 2018-10-05.

#### Added
- Initial release of Alamofire.
  - Added by [Viktor Olesenko](https://github.com/OlesenkoViktor).
