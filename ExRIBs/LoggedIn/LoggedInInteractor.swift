//
//  LoggedInInteractor.swift
//  ExRIBs
//
//  Created by 최윤제 on 2023/09/04.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing { // Router에 관리할 RIB 함수
    func cleanupViews()
    func routeToTicTacToe()
    func routeToOffGame()

}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable, LoggedInActionableItem {
    
    func gameDidEnd(withWinner winner: PlayerType?) {
        if let winner = winner {
            mutableScoreStream.updateScore(withWinner: winner)
        }
        router?.routeToOffGame()
    }
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    private let mutableScoreStream: MutableScoreStream
    
    private var games = [Game]()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
    }

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
    
    // MARK: - LoggedInActionableItem

    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())> {
        let game: Game? = games.first { game in
            return game.id.lowercased() == id?.lowercased()
        }

        if let game = game {
            router?.routeToGame(with: game.builder)
        }

        return Observable.just((self, ()))
    }
}
