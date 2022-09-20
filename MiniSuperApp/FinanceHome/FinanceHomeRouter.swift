import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
  
    private let superPayDashboardBuildable: SuperPayDashBoardBuildable
    private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    
    private var superPayRouting: Routing?
    private var cardOnFileRouting: Routing?
 
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashboardBuildable: SuperPayDashBoardBuildable,
        cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuildable = cardOnFileDashboardBuildable
        
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
        
        self.cardOnFileRouting = router
        attachChild(router)
        
        
    }

}
