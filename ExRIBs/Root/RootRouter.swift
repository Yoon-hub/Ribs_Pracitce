//
//  RootRouter.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let loggedOutBuilder: LoggedOutBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable, viewController: RootViewControllable, loggedtOutBuildable: LoggedOutBuildable) {
        
        self.loggedOutBuilder = loggedtOutBuildable
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    // attach 시켜주는 곳
    override func didLoad() {
        super.didLoad()
        let loggedOut = self.loggedOutBuilder.build(withListener: self.interactor)
        self.attachChild(loggedOut)
        self.viewController.present(viewController: loggedOut.viewControllable)
    }
}
