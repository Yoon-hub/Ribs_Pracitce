//
//  TicTacToeBuilder.swift
//  ExRIBs
//
//  Created by 최윤제 on 2023/09/04.
//

import RIBs

protocol TicTacToeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1Name: String { get }
    var player2Name: String { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    
    fileprivate var player1Name: String {
        return dependency.player1Name
    }
    
    fileprivate var player2Name: String {
        return dependency.player2Name
    }
}

// MARK: - Builder

protocol TicTacToeBuildable: Buildable {
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting
}

final class TicTacToeBuilder: Builder<TicTacToeDependency>, TicTacToeBuildable {
    
    override init(dependency: TicTacToeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting {
        let component = TicTacToeComponent(dependency: dependency)
        let viewController = TicTacToeViewController(player1Name: component.player1Name, player2Name: component.player2Name)
        let interactor = TicTacToeInteractor(presenter: viewController)
        interactor.listener = listener
        return TicTacToeRouter(interactor: interactor, viewController: viewController)
    }
}
