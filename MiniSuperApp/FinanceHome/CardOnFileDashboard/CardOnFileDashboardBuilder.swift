//
//  CardOnFileDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import ModernRIBs

protocol CardOnFileDashboardDependency: Dependency {
    var cardsOnFileRepository: CardOnFileResitory { get }
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {
    var cardsOnFileRepository: CardOnFileResitory { dependency.cardsOnFileRepository }
}

// MARK: - Builder

protocol CardOnFileDashboardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting
}

final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {

    override init(dependency: CardOnFileDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting {
        let component = CardOnFileDashboardComponent(dependency: dependency)
        let viewController = CardOnFileDashboardViewController()
        let interactor = CardOnFileDashboardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return CardOnFileDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
