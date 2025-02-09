//
//  ButtonCollectionDelegate.swift
//  TopMenu
//
//  Created by Abdusalom on 09/02/2025.
//

import UIKit

@MainActor
public protocol ButtonCollectionDelegate: AnyObject {
    func didTapButton(withTitle Title: String)
}

