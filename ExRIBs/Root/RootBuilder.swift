//
//  RootBuilder.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

extension RootComponent: LoggedOutDependency {
    
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
    }

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {  // root라 listenr가 필요없는 빌더
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        
        
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(interactor: interactor, viewController: viewController, loggedtOutBuildable: loggedOutBuilder)
    }
}
