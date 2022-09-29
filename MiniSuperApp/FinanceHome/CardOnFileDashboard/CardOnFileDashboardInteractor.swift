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

// 리블렛의 통신은 리블랫끼리: CardOnFileDashboardListener는 부모 리블렛의 인터렉터이다.
protocol CardOnFileDashboardListener: AnyObject {
    func cardOnFileDashboardDidTapAddPaymentMethod()
}

protocol CardOnFileDashboardInteractorDependency {
    var cardsOnFileRepository: CardOnFileResitory { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {


    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener? // 부모리블렛의 인터렉터

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
    
    func didTapAddPaymentMethod() {
        // CardOnFileDashboard는 화면의 일부만 담당하기 때문에 모달띄우는 역할은 부모가 띄우는게 명확해 보임.
        // 리블렛끼리의 통신은 인터렉터끼리
        listener?.cardOnFileDashboardDidTapAddPaymentMethod()
        print("CardOnFileDashboardInteractor, didTapAddPaymentMethod")
    }
    
}
