//
//  LoggedInRouter.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: ViewableRouter<LoggedInInteractable, LoggedInViewControllable>, LoggedInRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable, offGameBuilder: OffGameBuildable) {
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private var offGameBuilder: OffGameBuildable
    private var currentChild: ViewableRouting?

    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }
    
    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
    
    private func attachOffGame() {
        let offGame = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController: offGame.viewControllable)
    }
    
    func routeToTicTacToe() {

    }

    func routeToOffGame() {
        detachCurrentChild()
        attachOffGame()
    }
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
    
    
}

