//
//  ColorTheme.swift
//  TipCalculator
//
//  Created by Rick Jacobson on 1/29/21.
//  Copyright © 2021 Make School. All rights reserved.
//

import Foundation
import UIKit

struct ColorTheme {
    
    let isDefaultStatsBar: Bool
    let viewControllerBackgroundColor: UIColor
    
    let primaryColor: UIColor
    let primaryTextColor: UIColor
    
    let secondaryColor: UIColor
    
    let accentColor: UIColor
    let outputTextColor: UIColor
    
    // Create Light Theme
    static let light = ColorTheme(isDefaultStatsBar: true,
                                  viewControllerBackgroundColor: .tcOffWhite,
                                  primaryColor: .tcWhite,
                                  primaryTextColor: .tcCharcoal,
                                  secondaryColor: .tcDarkBlue,
                                  accentColor: .tcHotPink,
                                  outputTextColor: .tcAlmostBlack)

    // Create Dark theme
    static let dark = ColorTheme(isDefaultStatsBar: false,
                                  viewControllerBackgroundColor: .tcAlmostBlack,
                                  primaryColor: .tcMediumBlack,
                                  primaryTextColor: .tcWhite,
                                  secondaryColor: .tcBlueBlack,
                                  accentColor: .tcSeafoamGreen,
                                  outputTextColor: .tcWhite)
}
