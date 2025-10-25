> [!NOTE]
> This is a mirror of CatWalk plasmoid from https://store.kde.org/p/2055225/ and https://store.kde.org/p/2137844/ , aims to preserve the history and make it easy for distribution packaging.

# CatWalk

A simple plasmoid showing the total CPU usage. Visually made like RunCat.

|animated preview|preview|
|:-:|:-:|
|![animated preview](https://images.pling.com/img/00/00/52/72/79/2137844/catwalk.gif)|![preview](https://images.pling.com/img/00/00/52/72/79/2137844/screenshot-20230623-1500192.png)|

Special thanks to [Nikita Beloglazov](https://github.com/NikitaBeloglazov) for animated preview!

## Installation

### Manual installation

Manual installation: unpack `org.kde.plasma.catwalk` to `~/.local/share/plasma/plasmoids`.

### Build and install with CMake

```shell
# dependencies: cmake extra-cmake-modules ki18n
cmake -S . -B build
cmake --build build
cmake --install build
```
