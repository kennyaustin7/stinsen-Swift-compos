import Foundation
import SwiftUI

struct ViewCoordinatableView<T: ViewCoordinatable, U: View>: View {
    var coordinator: T
    let router: ViewRouter<T.Route>
    @ObservedObject var children: ViewChild
    private var customize: (AnyView) -> U

    init(coordinator: T, customize: @escaping (AnyView) -> U) {
        self.router = ViewRouter(coordinator)

        if let routerIdentifiable = coordinator as? RouterIdentifiable {
            RouterStore.shared.store(id: routerIdentifiable.routerId, router: router)
        }
        
        self.customize = customize
        self.coordinator = coordinator
        self.children = coordinator.children
    }
        
    var body: some View {
        customize(
            AnyView(
                Group {
                    if let childCoordinator = coordinator.childCoordinators.first {
                        childCoordinator.coordinatorView()
                    } else {
                        coordinator.start()
                    }
                }
            )
        )
        .environmentObject(router)
    }
}
