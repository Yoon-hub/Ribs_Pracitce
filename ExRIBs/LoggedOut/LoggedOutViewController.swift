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
    func logOut(id: String, pw: String)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    
    @IBAction func logOutTap(_ sender: UIButton) {
        listener?.logOut(id: idTF.text!, pw: pwTF.text!)
    }
    
}
