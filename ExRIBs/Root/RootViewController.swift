//
//  RootViewController.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    func present<T: UIViewController>(viewController: ViewControllable, from: T.Type) {
        let sb = UIStoryboard(name: "loggedOut", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: type(of: viewController.uiviewController))) as! T
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
