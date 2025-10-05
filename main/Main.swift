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

@_cdecl("app_main")
func app_main() {
  print("Smart Light starting up...")

  // let led = LED()
  let light_switch = Switch()

  // (1) Create a Matter root node
  let rootNode = Matter.Node()
  rootNode.identifyHandler = {
    print("identify")
  }

  let lightSwitchEndpoint = Matter.OnOffLight(node: rootNode)
  lightSwitchEndpoint.eventHandler = { event in
    print("lightEndpoint.eventHandler:")
    print(event.attribute)
    print(event.value)

    switch event.attribute {
    case .onOff:
      light_switch.enabled = (event.value == 1)
    default:
      break
    }
  }
  // (3) Add the endpoint to the node
  rootNode.addEndpoint(lightSwitchEndpoint)

  // (4) Provide the node to a Matter application and start it
  let app = Matter.Application()
  app.rootNode = rootNode
  app.start()
}
