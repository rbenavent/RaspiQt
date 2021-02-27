# for Qt & QML


## HOW IT WORKS:


## USAGE:


## Tested OS:
- Ubuntu 20.04
- MacOS Big Sur
- Windows 10


## Tested main loop locks:
- QML js infinite loop
- C++ infinite loop
- C++ mutex double lock

## Restart estrategy
- Windows : QProcess::startDetached + std::exit (application arguments are kept)
- Linux & macOs : exec (application arguments are kept)

## Delayed restart estrategy
- Windows : cmd.exe
- Linux & MacOs : bash

## License
 Main loop WDT for Qt & QML is released under the terms of the **GNU LGPL v3 License**. Full details in `license.txt` file.
