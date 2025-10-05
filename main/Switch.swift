//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

// Helper object that can be used to control the ESP32C6 on-board LED. Settings
// the `enabled`, `brightness`, `color` properties immediately propagates those
// to the physical LED.
final class Switch {
  // Whether the GPIO output should be HIGH or LOW
  var enabled: Bool = true {
    didSet {
      gpio_set_level(gpio_num_t(gpioNum), enabled ? 1 : 0)
    }
  }

  let gpioNum: Int32 = 22  // GPIO pin number

  init() {
    // Configure the GPIO pin as output
    gpio_reset_pin(gpio_num_t(gpioNum))
    gpio_set_direction(gpio_num_t(gpioNum), GPIO_MODE_OUTPUT)
    // Set initial state
    gpio_set_level(gpio_num_t(gpioNum), 1)
  }
}
