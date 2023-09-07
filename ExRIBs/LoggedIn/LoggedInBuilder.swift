//
//  LoggedInBuilder.swift
//  ExRIBs
//
//  Created by 최윤제 on 2023/09/04.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var LoggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.

}

final class LoggedInComponent: Component<LoggedInDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }
    
    let player1Name: String
    let player2Name: String

    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
    }
    
    var mutableScoreStream: MutableScoreStream {
        return shared { ScoreStreamImpl() }
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, player1: String, player2: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, player1: String, player2: String) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency, player1Name: player1, player2Name: player2)
        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener
        let offGameBuilder = OffGameBuilder(dependency: component)
        let ticTacToeBuilder = TicTacToeBuilder(dependency: component)
        
        
        return LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController, offGameBuilder: offGameBuilder, ticTacToeBuilder: ticTacToeBuilder)
    }
}
    