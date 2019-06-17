//
//  ViewControllers.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 17/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

func loadRootViewController() -> RootViewController {
  let window = UIApplication.shared.windows[0]
  return window.rootViewController as! RootViewController
}
