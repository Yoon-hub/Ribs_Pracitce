//
//  LoggedInBuilder.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency>, OffGameDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
//    fileprivate var loggedInViewController: LoggedInViewControllable {
//        return dependency.loggedInViewController
//    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency)
        let viewController = LoggedInViewController()
        let interactor = LoggedInInteractor(presenter: viewController)
        let offGame = OffGameBuilder(dependency: component)
        
        interactor.listener = listener
        return LoggedInRouter(interactor: interactor, viewController: viewController, offGameBuilder: offGame)
    }
}
