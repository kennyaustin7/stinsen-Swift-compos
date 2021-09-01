import Foundation
import SwiftUI

import Stinsen

final class TestbedRouterObjectCoordinator: NavigationCoordinatable {
    lazy var navigationStack = NavigationStack(self)
    
    enum Route {
        case pushScreen
        case modalScreen
        case pushCoordinator
        case modalCoordinator
        @available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
        case coverScreen
        @available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
        case coverCoordinator
    }
    
    deinit {
        print("Deallocated TestbedRouterObjectCoordinator")
    }

    func resolveRoute(route: Route) -> Transition {
        switch route {
        case .modalCoordinator:
            return .modal(
                AnyCoordinatable(
                    NavigationViewCoordinator(TestbedRouterObjectCoordinator())
                )
            )
        case .pushCoordinator:
            return .push(
                AnyCoordinatable(
                    TestbedRouterObjectCoordinator()
                )
            )
        case .pushScreen:
            return .push(
                AnyView(
                    TestbedRouterObjectScreen()
                        .navigationTitle(with: "Pushed testbed")
                )
            )
        case .modalScreen:
            return .modal(
                AnyView(
                    NavigationView {
                        TestbedRouterObjectScreen().navigationTitle(with: "Modal testbed")
                    }
                )
            )
        case .coverScreen:
            if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                return .fullScreen(
                    AnyView(
                        NavigationView {
                            TestbedRouterObjectScreen().navigationTitle(with: "Cover testbed")
                        }
                    )
                )
            } else {
                fatalError()
            }
        case .coverCoordinator:
            if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                return .fullScreen(
                    AnyView(
                        NavigationView {
                            TestbedRouterObjectScreen().navigationTitle(with: "Cover testbed")
                        }
                    )
                )
            } else {
                fatalError()
            }
        }
    }
    
    @ViewBuilder func start() -> some View {
        TestbedRouterObjectScreen()
            .navigationTitle(with: "Coordinator testbed")
    }
}
