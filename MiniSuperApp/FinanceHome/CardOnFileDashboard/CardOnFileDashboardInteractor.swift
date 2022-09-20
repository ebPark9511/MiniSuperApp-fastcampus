//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
    
    func update(with viewmodels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol CardOnFileDashboardInteractorDependency {
    var cardsOnFileRepository: CardOnFileResitory { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

    private let dependency: CardOnFileDashboardInteractorDependency
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: CardOnFileDashboardPresentable,
        dependency: CardOnFileDashboardInteractorDependency
    ) {
        
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        
        dependency.cardsOnFileRepository.cardOnFile.sink { methods in
            let viewModels = methods.prefix(5).map( PaymentMethodViewModel.init )
            self.presenter.update(with: viewModels)
        }.store(in: &cancellables)
        
    }

    override func willResignActive() { // deattach 전에 불림.
        super.willResignActive()
        
        cancellables.forEach{ $0.cancel() }
        cancellables.removeAll()
        
    }
}
