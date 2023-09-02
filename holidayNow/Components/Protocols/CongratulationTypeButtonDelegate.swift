//
//  CongratulationTypeButtonDelegate.swift
//  holidayNow
//
//  Created by Евгений on 01.09.2023.
//

import Foundation

protocol CongratulationTypeButtonDelegate: AnyObject {
    func synchronizeOtherButtons(title: String, state: Bool)
}
