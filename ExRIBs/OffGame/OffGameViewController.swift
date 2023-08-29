//
//  OffGameViewController.swift
//  RibsEx
//
//  Created by VP on 2023/08/28.
//

import RIBs
import RxSwift
import UIKit

protocol OffGamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {

    weak var listener: OffGamePresentableListener?
}
