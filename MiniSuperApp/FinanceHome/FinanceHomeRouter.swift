import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
  
    private let superPayDashboardBuildable: SuperPayDashBoardBuildable
    private var superPayRouting: Routing?
 
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashboardBuildable: SuperPayDashBoardBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
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

}
