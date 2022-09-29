import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashboardListener, AddPaymentMethodListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    private let superPayDashboardBuildable: SuperPayDashBoardBuildable
    private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    
    private var superPayRouting: Routing?
    private var cardOnFileRouting: Routing?
    private var addPaymentMethodRouting: Routing?
 
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashboardBuildable: SuperPayDashBoardBuildable,
        cardOnFileDashboardBuildable: CardOnFileDashboardBuildable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuildable = cardOnFileDashboardBuildable
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    
    func attachSuperPayDashboard() {
        
        if superPayRouting != nil {
            return
        }
        
        // 리스너: 자식리블렛의 리스너는 비즈니스로직을 담당하는 인터렉터가 됩니다.
        let router = superPayDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
            
        self.superPayRouting = router
        attachChild(router)
        
    }
    
    func attachCardOnDashboard() {
        
        if cardOnFileRouting != nil {
            return
        }
        
        let router = cardOnFileDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        
        self.addPaymentMethodRouting = router
        attachChild(router)
        
        
    }
    
    // 뷰컨을 띄웠던 부모가 자식뷰컨을 반드시 삭제하는것을 보장해야함 -> 자식뷰컨의 닫기는 부모가 관리해야함 ( 재사용하기 위해 )
    func attachAddPaymentMethod() {
        if addPaymentMethodRouting != nil {
            return
        }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        let navigation = NavigationControllerable(root: router.viewControllable)
        viewControllable.present(navigation, animated: true, completion: nil)
        
        addPaymentMethodRouting = router
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else {
            return
        }
        
        viewControllable.dismiss(completion: nil)
        detachChild(router)
        addPaymentMethodRouting = nil
    }

}
