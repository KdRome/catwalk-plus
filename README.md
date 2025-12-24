# CatWalk+

This project is a fork of CatWalk (https://invent.kde.org/heddxh/applet-catwalk), enhanced with additional features that I found useful and believe others will appreciate as well.

A simple plasmoid showing the total CPU, GPU, RAM usage. Visually made like RunCat.

|animated preview|preview|
|:-:|:-:|
|![animated preview](https://images.pling.com/img/00/00/52/72/79/2137844/catwalk.gif)|![preview](https://images.pling.com/img/00/00/52/72/79/2137844/screenshot-20230623-1500192.png)|

Special thanks to [Nikita Beloglazov](https://github.com/NikitaBeloglazov) for animated preview!

## Installation

### Manual installation

Manual installation: unpack `org.kde.plasma.catwalk+` to `~/.local/share/plasma/plasmoids`.

### Build and install with CMake

```shell
# dependencies: cmake extra-cmake-modules ki18n
cmake -S . -B build
cmake --build build
cmake --install build
```

### What's New in CatWalk+

- Choose what to monitor (CPU, GPU, or RAM) with a simple radio button.
- Show or hide the prefix for the monitored value.
- Tooltip displays what the number represents, even if the prefix is hidden.
- Option to swap the arrangement of the animation and text.
- Run multiple instances to monitor CPU, GPU, and RAM usage simultaneously, no need to open the system monitor.