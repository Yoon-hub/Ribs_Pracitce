//
//  LoggedOutBuilder.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs
import UIKit

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutComponent: Component<LoggedOutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let component = LoggedOutComponent(dependency: dependency)
        
        let sb = UIStoryboard(name: "loggedOut", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "LoggedOutViewController") as! LoggedOutViewController
        
        let interactor = LoggedOutInteractor(presenter: vc)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: vc)
    }
}
