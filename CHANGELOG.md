# Change Log
All notable changes to this project will be documented in this file.
`SKLocalizable ` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases
- `1.0.x` Releases - [1.0.1](#101) | [1.0.2](#102)


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
