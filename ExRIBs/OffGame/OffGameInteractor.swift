//
//  OffGameInteractor.swift
//  RibsEx
//
//  Created by VP on 2023/08/28.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    // UI를 처리하는 역할 Interactor -> ViewContoller
    func set(scroe: Score)
}

protocol OffGameListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didStartGame()
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {

    weak var router: OffGameRouting?
    weak var listener: OffGameListener?
    
    private var scoreStream: ScoreStream
    

    // TODO: Add additional dependencies to constructor. Do not perform any logic
     init(presenter: OffGamePresentable, socreStream: ScoreStream) {
         self.scoreStream = socreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        udpateScore()
    
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func startGame() {
        listener?.didStartGame()
    }
    
    func udpateScore() {
        scoreStream.score
            .subscribe(
                onNext: { score in
                    self.presenter.set(scroe: score)
                }
            )
            .disposeOnDeactivate(interactor: self)
    }
}
