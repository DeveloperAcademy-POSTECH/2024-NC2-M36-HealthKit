//
//  NavigationPath.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/18/24.
//

import SwiftUI

enum NavigationPathType {
    case homeView
    case academyView
    case animationView
}

@Observable
final class NavigationPathModel: PathModel {
    var paths: [NavigationPathType]
    
    init(paths: [NavigationPathType] = []) {
        self.paths = paths
    }
}

private struct NavigationPathDestination: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationPathType.self) { path in
                switch path {
                case .homeView: HomeView().navigationBarBackButtonHidden()
                case .academyView: AcademyView()
                case .animationView: AnimationView().navigationBarBackButtonHidden()
                }
            }
    }
}

protocol PathModel {
    associatedtype PathType: Hashable
    var paths: [PathType] { get }
}

extension View {
    
    func navigationPathDestination() -> some View {
        self.modifier(NavigationPathDestination())
    }
}
