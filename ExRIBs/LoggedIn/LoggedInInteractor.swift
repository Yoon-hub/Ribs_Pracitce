//
//  LoggedInInteractor.swift
//  ExRIBs
//
//  Created by 최윤제 on 2023/09/04.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToTicTacToe()
    func routeToOffGame()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
    
    func gameDidEnd(withWinner winner: PlayerType?) {
        
    }
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func didStartGame() {
        router?.routeToTicTacToe()
    }
}
