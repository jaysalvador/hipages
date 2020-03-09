# HiPages Demo #

<p align="left">
  <img src="https://raw.githubusercontent.com/jaysalvador/hipages/master/demo.png" width="150" alt="accessibility text">
</p>

This app showcases some of my work using MVVM architecture and Protocol-oriented programming in Swift.

### API ###

- Utilises `Codable` protocol and `Result` type
- Uses `JSONDecoder` to handle JSON parsing

### Views/Controllers ###

- Utilises `UICollectionView` to render items 
- Uses `Dwifft` library to seamlessly handle collection item differences/changes that are defined in `Sections` and `Items` enums, comparable via the `Equatable` protocol.

