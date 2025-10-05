# Embedded Swift & Matter: Smart Light (On/Off switch)

## Overview

This directory contains an example implementation of a Matter smart light accessory in Embedded Swift, and it can be built using the ESP IDF and ESP Matter SDKs, and uploaded to an ESP32C6 or ESP32C3 development board.

> [!NOTE]
> This repository is based on an example provided by Apple in the [swift-matter-examples](https://github.com/swiftlang/swift-matter-examples) repository.


#### Embedded Swift

Embedded Swift is a subset of Swift designed for constrained environments, such as embedded devices, kernel code, and other low-level systems. It includes most Swift language features, like generics, value and reference types, optionals, error handling, and more. Embedded Swift introduces the safety and expressivity of Swift to environments usually dominated by C or C++ code. To learn more, see [A Vision for Embedded Swift](https://github.com/swiftlang/swift-evolution/blob/main/visions/embedded-swift.md).

#### Matter

Matter is an open standard for building smart home accessories, supported natively by many smart home ecosystems such as HomeKit. For more information about Matter, see the [Matter documentation](https://project-chip.github.io/connectedhomeip-doc/index.html).


## Getting Started

### Requirements

Before running the examples, ensure you have the following tools available:

- Hardware:
  - [ESP32-C6-DevKitC-1-N8](https://docs.espressif.com/projects/espressif-esp-dev-kits/en/latest/esp32c6/esp32-c6-devkitc-1/user_guide.html)
  - Have a set up HomeKit or other Matter-enabled smart home ecosystem.
    - For HomeKit, this includes a configured home, a Wi-Fi network which additional devices can join, a [home hub](https://support.apple.com/en-us/102557), and an iOS device for managing the home.
- Software
  - [Swift Nightly Toolchain](https://www.swift.org/download)
  - [CMake 3.29+](https://cmake.org/download)
  - [ESP-IDF v5.4.1](https://docs.espressif.com/projects/esp-idf/en/v5.4.1/esp32c6/get-started/index.html)
  - [ESP-Matter SDK 1.2](https://docs.espressif.com/projects/esp-matter/en/latest/esp32c6/introduction.html)

> [!IMPORTANT]
> This implementation is designed for an Espressif C6 Development Kit and built with macOS (or Linux).

## Building and running

> [!IMPORTANT]
> Make sure you have first properly set up the ESP-IDF development environment as shown in this [tutorial](https://github.com/Rodrigue2g/Share/blob/main/src/embedded/embedded-swift.sh).


For full steps how to build the example code, follow the [Setup Your Environment](https://apple.github.io/swift-embedded/swift-matter-examples/tutorials/tutorial-table-of-contents#setup-your-environment) tutorials and the [Explore the Smart Light example](https://apple.github.io/swift-matter-examples/tutorials/swiftmatterexamples/run-example-smart-light) tutorial. In summary:

- Ensure your system has all the required software installed and your shell has access to the tools listed in the top-level README file.
- Plug in the ESP32C6/C3 development board via a USB cable.
- Have a set up HomeKit or other Matter-enabled smart home ecosystem.
  - For HomeKit, this includes a configured home, a Wi-Fi network which additional devices can join, a [home hub](https://support.apple.com/en-us/102557), and an iOS device for managing the home.

1. Clone the repository and navigate to the root folder.
  ```shell
  $ git clone https://github.com/Rodrigue2g/matter-smart-light.git
  $ cd matter-smart-light
  ```

2. Configure the build system for your microcontroller, this should also be runnable on `esp32c3`.
  ```shell
  $ idf.py set-target esp32c6
  ```

3. Build and deploy the application to your device.
  ```shell
  $ idf.py build flash monitor
  ```

4. Register the device in your home network. See [Connect-using-Matter](https://apple.github.io/swift-matter-examples/tutorials/swiftmatterexamples/run-example-smart-light#Connect-using-Matter) for detailed pairing instructions with HomeKit.

If you need a pairing code, it will most likely be `2020-2021` 

5. You can now control the smart light. In case of a HomeKit network, the Home app, and Siri can both be used to turn the light on & off.


## Debugging

As mentioned in this [issue](https://github.com/espressif/esp-matter/issues/1115), you might run into a bug when building this project, with the following ouput build logs:
````
/home/../light/managed_components/espressif__esp_insights/src/esp_insights_cbor_encoder.c:176:22: error: 'SHA_SIZE' undeclared here (not in a function)
  176 |     char sha_sum[2 * SHA_SIZE + 1];
      |                      ^~~~~~~~
/home/../light/managed_components/espressif__esp_insights/src/esp_insights_cbor_encoder.c: In function 'encode_data_points':
/home/../light/managed_components/espressif__esp_insights/src/esp_insights_cbor_encoder.c:587:20: error: 'rtc_store_non_critical_data_hdr_t' has no member named 'dg'
  587 |         if (!header.dg || !esp_ptr_in_drom(header.dg) || !header.len) {
      |                    ^
/home/../light/managed_components/espressif__esp_insights/src/esp_insights_cbor_encoder.c:587:50: error: 'rtc_store_non_critical_data_hdr_t' has no member named 'dg'
  587 |         if (!header.dg || !esp_ptr_in_drom(header.dg) || !header.len) {
      |                                                  ^
...
ninja: build stopped: subcommand failed.
````
To fix it, simply run:
```
$ idf.py add-dependency "espressif/esp_diag_data_store==1.0.1"
```
And try to build again.