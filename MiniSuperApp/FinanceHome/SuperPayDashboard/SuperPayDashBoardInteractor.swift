//
//  SuperPayDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/20.
//

import ModernRIBs
import Combine
import Foundation


protocol SuperPayDashBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashBoardPresentable: Presentable {
    var listener: SuperPayDashBoardPresentableListener? { get set }
    
    func updateBalance(_ balance: String)
}

protocol SuperPayDashBoardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    var balanceFormater: NumberFormatter { get }

}


final class SuperPayDashBoardInteractor: PresentableInteractor<SuperPayDashBoardPresentable>, SuperPayDashBoardInteractable, SuperPayDashBoardPresentableListener {

    weak var router: SuperPayDashBoardRouting?
    weak var listener: SuperPayDashBoardListener?

    private let dependency: SuperPayDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
 
    init(
        presenter: SuperPayDashBoardPresentable,
        dependency: SuperPayDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()

        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        self.dependency.balance.sink(receiveValue: { [weak self] balance in
             
            self?.dependency.balanceFormater.string(from: NSNumber(value: balance)).map({
                // 프레젠터는 뷰컨트롤러에서 SuperPayDashboardPresentable를 컨펌하고 있다.
                self?.presenter.updateBalance($0)
            })
            
        }).store(in: &cancellables)
        
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
