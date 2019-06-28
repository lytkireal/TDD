//
//  RootViewController+Tests.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 17/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

extension RootViewController {
  var stepController: StepCountController {
    return children.first { $0 is StepCountController } as! StepCountController
  }
}
