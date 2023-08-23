//
//  AppComponent.swift
//  RibsEx
//
//  Created by VP on 2023/08/23.
//

import Foundation
import RIBs


// RIB에 종속성 관리
class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}



