//
//  OffGameViewController.swift
//  RibsEx
//
//  Created by VP on 2023/08/28.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SnapKit

protocol OffGamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func startGame()
}

class OffGameView: UIView {
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("game start", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {

    weak var listener: OffGamePresentableListener?
    
    let offGameView = OffGameView()
    let dispose = DisposeBag()
    
    override func loadView() {
        self.view = offGameView
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        offGameView.startButton.rx.tap
            .bind { [weak self] in
                self?.listener?.startGame()
            }
            .disposed(by: dispose)
    }
    
}
