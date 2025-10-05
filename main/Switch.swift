//  A simple Swift class for controlling a GPIO output pin (GPIO 22) on an ESP32-C6 device.
//  When `enabled` is set, the corresponding GPIO pin is driven HIGH or LOW.
//  This implementation assumes the ESP-IDF has been properly set up for Swift interop.
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
