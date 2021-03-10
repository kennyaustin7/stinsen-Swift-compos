import Foundation
import SwiftUI

///The ViewCoordinatable represents a view with routes that can be switched to but not pushed or presented modally. This can be used if you have a need to switch between different "modes" in the app, for instance if you switch between logged in and logged out.
public protocol ViewCoordinatable: Coordinatable {
    associatedtype Route
    associatedtype Start: View
    func route(to route: Route)
    func resolveRoute(route: Route) -> AnyCoordinatable
    @ViewBuilder func start() -> Start
    var children: Children { get }
}

public extension ViewCoordinatable {
    var childCoordinators: [AnyCoordinatable] {
        children.childCoordinators
    }
    
    var childDismissalAction: DismissalAction {
        get {
            children.childDismissalAction
        } set {
            children.childDismissalAction = newValue
        }
    }
    
    var appearingMetadata: AppearingMetadata? {
        return nil
    }

    func route(to route: Route) {
        let resolved = resolveRoute(route: route)
        self.children.childCoordinators = [resolved]
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(
            ViewCoordinatableView(coordinator: self)
        )
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        fatalError("not implemented")
    }
}
