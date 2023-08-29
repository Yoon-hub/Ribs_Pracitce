//
//  LoggedInInteractor.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs
import RxSwift

protocol LoggedInRouting: ViewableRouting {
    // 하위 트리를 관리하기 위한 메서드 선언
    func routeToTicTacToe()
    func routeToOffGame()
    func cleanupViews()
}

protocol LoggedInPresentable: Presentable {
    var listener: LoggedInPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: PresentableInteractor<LoggedInPresentable>, LoggedInInteractable, LoggedInPresentableListener {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedInPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // offset이나 gameover에서 자기 Listner로 호출하겠지?
    func gameDidEnd() {
        router?.routeToOffGame()
    }
}
