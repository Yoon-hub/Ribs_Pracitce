//
//  LoggedOutViewController.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    
    @IBAction func logOutTap(_ sender: UIButton) {
        
    }
    
}
