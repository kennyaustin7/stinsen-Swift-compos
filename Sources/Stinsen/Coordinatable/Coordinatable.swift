import Foundation
import SwiftUI

/// A Coordinatable usually represents some kind of flow in the app. You do not need to implement this directly if you're not toying with other types of navigation e.g. a hamburger menu, but rather you would implement TabCoordinatable, NavigationCoordinatable or ViewCoordinatable.
public protocol Coordinatable: ObservableObject, Identifiable {
    /// This function is used internally for Stinsen, do not implement. Returns a view for the coordinator.
    func coordinatorView() -> AnyView
    /// This function is used internally for Stinsen, do not implement. The ID for the coordinator. Will not be unique across instances of the coordinator.
    var id: String { get }
    /// This function is used internally for Stinsen, do not implement. The active child-coordinators of the coordinator
    var childCoordinators: [AnyCoordinatable] { get }
    /// This function is used internally for Stinsen, do not implement. Will dismiss child coordinator.
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?)
    /// This function is used internally for Stinsen, do not implement. Stinsen sets this while dismissing a coordinator.
    var dismissalAction: DismissalAction { get set }
    /// Handles a chain of routes, for example when deep linking to the app externally. This chain is validated at runtime and will throw an error if it is not valid. Each coordinator will handle the routing in its own way, but generally they will route to the first route in the array (provided it is not the active route), and then run the function again on the coordinator it routed to, using the same array with the first item removed. Implement this if you want custom handling.
    func handleDeepLink(_ deepLink: [Any]) throws
}

public typealias DismissalAction = (() -> Void)?

public extension Coordinatable {
    var allChildCoordinators: [AnyCoordinatable] {
        return childCoordinators.flatMap { [$0] + $0.allChildCoordinators }
    }
}

public extension Coordinatable {
    var id: String {
        return ObjectIdentifier(self).debugDescription + NSStringFromClass(Self.self) //objc-name for better debugging
    }
}
