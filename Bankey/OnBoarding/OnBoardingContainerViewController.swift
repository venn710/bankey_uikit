//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 13/09/24.
//

import UIKit
/*
 Container View Controller is a special type of view controller that manages other child view controllers. It's different from a normal view controller because it acts as a container for other view controllers, allowing you to create complex layouts and navigation structures by embedding child view controllers within it.
 
 Key Differences between Container View Controller and Normal View Controller:
 
 1. Container View Controller:
 Purpose: A container view controller's primary job is to organize and manage the display of multiple child view controllers within its view hierarchy. It doesn’t usually present its own content but rather controls how its child view controllers are displayed.

 Examples:
 
 UINavigationController: Manages a stack of view controllers and allows navigation through a push/pop interface.
 
 UITabBarController: Manages multiple child view controllers, each associated with a tab bar item, allowing users to switch between them.
 
 UISplitViewController: Manages two view controllers (primary and secondary) in a split-view layout, often used on iPads.
 
 UIPageViewController: Allows users to navigate between view controllers via swiping gestures, often used for onboarding flows or paginated content.
 
 Child View Controller Management:
 A container view controller can embed one or more child view controllers using the addChild(_:​) and removeFromParent() methods.
 It is responsible for managing transitions between its child view controllers and organizing their layout within its own view hierarchy.
 
 Communication Between Child View Controllers:
 Child view controllers are independent but can communicate with each other or with the container through delegation, notifications, or direct method calls.
 
 
 2. Normal View Controller:
 Purpose: A normal view controller is responsible for managing a single screen of content or a single logical unit of user interaction. It typically manages its own content, which could be labels, buttons, images, etc.
 
 Examples:
 
 UIViewController: This is the base class for all view controllers and is used to manage a single view and its associated user interactions.
 A normal view controller focuses on its own lifecycle (e.g., viewDidLoad, viewWillAppear, etc.) and does not manage other child view controllers.
 
 Hierarchy: In most cases, it is either embedded in a container view controller (e.g., in a navigation or tab bar controller) or presented directly.
 
 */
class OnBoardingContainerViewController: UIViewController {
    
    let uiPageViewController: UIPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    var pages: [UIViewController] = [VC1(), VC2(), VC3()]

    var currentVC: UIViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
    }

    private func configure() {
        
        currentVC = pages.first
        view.backgroundColor = .purple
        
        // UIPageViewController
        uiPageViewController.dataSource = self
        uiPageViewController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        uiPageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
    
    private func addSubViews() {
        
        // This method creates a parent-child relationship between the current view controller and the object in the childController parameter. This relationship is necessary when embedding the child view controller’s view into the current view controller’s content. If the new child view controller is already the child of a container view controller, it is removed from that container before being added
        addChild(uiPageViewController)
        view.addSubview(uiPageViewController.view)
        uiPageViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            uiPageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiPageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiPageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            uiPageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension OnBoardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index > 0 else {
            return nil
        }
        currentVC = pages[index-1]
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index < pages.count - 1 else {
            return nil
        }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    
    // Have to implement these two functions below to show the indexes like dots.(PageControl)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC,
           let index = pages.firstIndex(of: currentVC) else {
            return 0
        }
        return index
    }

}


class VC1: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}

class VC2: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .orange
    }
}

class VC3: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .yellow
    }
}
