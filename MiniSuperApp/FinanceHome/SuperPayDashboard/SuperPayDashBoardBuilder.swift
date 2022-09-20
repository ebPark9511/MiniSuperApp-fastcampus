//
//  SuperPayDashBoardBuilder.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import Foundation
import ModernRIBs

// 부모에서 받고 싶은 의존성은 이곳에서 선언해주면된다.
protocol SuperPayDashBoardDependency: Dependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

// 컴포넌트는 리블렛과 자식 리블렛이 필요한 객체들을 담고 있는 바구니임.
final class SuperPayDashBoardComponent: Component<SuperPayDashBoardDependency>, SuperPayDashboardInteractorDependency {
    var balanceFormater: NumberFormatter { Formatter.balanceFormatter }
    var balance: ReadOnlyCurrentValuePublisher<Double> { dependency.balance }
}

// MARK: - Builder

protocol SuperPayDashBoardBuildable: Buildable {
    func build(withListener listener: SuperPayDashBoardListener) -> SuperPayDashBoardRouting
}

final class SuperPayDashBoardBuilder: Builder<SuperPayDashBoardDependency>, SuperPayDashBoardBuildable {

    override init(dependency: SuperPayDashBoardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuperPayDashBoardListener) -> SuperPayDashBoardRouting {
        let component = SuperPayDashBoardComponent(dependency: dependency)
        let viewController = SuperPayDashBoardViewController()
        let interactor = SuperPayDashBoardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SuperPayDashBoardRouter(interactor: interactor, viewController: viewController)
    }
}
