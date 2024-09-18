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
        navigationOrientation: .horizontal,
        options: nil
    )
    
    var pages: [UIViewController] = [
        OnBoardingViewController(imageResource: .delorean, data: "Bankey is faster, easier to use and has a brand new look and feel that will make you feel like you are back in the 80s"),
        OnBoardingViewController(imageResource: .world, data: "Move your money around the world quickly and securely."),
        OnBoardingViewController(imageResource: .thumbs, data: "Learn more at www.bankey.com"),
    ]
    
    var currentVC: UIViewController? {
        didSet {
            changeOnBoardingStatus()
        }
    }
    var closeButton = UIButton(configuration:.plain())
    
    var onBoardingStatusStackView = UIStackView()
    var onBoardingStatusLeading = UIButton(configuration:.plain())
    var onBoardingStatusTrailing = UIButton(configuration:.plain())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
        layoutSubViews()
    }
    
    private func configure() {
        
        view.backgroundColor = .purple
        navigationController?.navigationBar.isHidden = true
        currentVC = pages.first
        
        closeButton.setTitle("close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(onBoardingFinished), for: .touchUpInside)
        
        onBoardingStatusLeading.translatesAutoresizingMaskIntoConstraints = false
        onBoardingStatusTrailing.translatesAutoresizingMaskIntoConstraints = false
        
        onBoardingStatusLeading.addTarget(self, action: #selector(statusLeadingTapped), for: .touchUpInside)
        onBoardingStatusTrailing.addTarget(self, action: #selector(statusTrailingTapped), for: .touchUpInside)
        
        // UIPageViewController
        uiPageViewController.dataSource = self
        uiPageViewController.delegate = self
        uiPageViewController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        uiPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // onBoardingStatusStackView
        onBoardingStatusStackView.axis = .horizontal
        onBoardingStatusStackView.distribution = .equalSpacing
        onBoardingStatusStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func addSubViews() {
        
        view.addSubview(onBoardingStatusStackView)
        view.addSubview(closeButton)
        
        // This method creates a parent-child relationship between the current view controller and the object in the childController parameter. This relationship is necessary when embedding the child view controller’s view into the current view controller’s content. If the new child view controller is already the child of a container view controller, it is removed from that container before being added
        addChild(uiPageViewController)
        view.addSubview(uiPageViewController.view)
        uiPageViewController.didMove(toParent: self)
        
        view.bringSubviewToFront(closeButton)
        view.bringSubviewToFront(onBoardingStatusStackView)
        
        onBoardingStatusStackView.addArrangedSubview(onBoardingStatusLeading)
        onBoardingStatusStackView.addArrangedSubview(onBoardingStatusTrailing)
    }
    
    private func layoutSubViews() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            uiPageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            uiPageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            uiPageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiPageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            onBoardingStatusStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            onBoardingStatusStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            onBoardingStatusStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Delegation
extension OnBoardingContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        getPreviousVC(before: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        getNextVC(after: viewController)
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentVC = pageViewController.viewControllers?.first
        }
    }
    
}

// MARK: - Utils
extension OnBoardingContainerViewController {
    
    private var isFirstVC: Bool {
        currentVC == pages.first
    }
    
    private var isLastVC: Bool {
        currentVC == pages.last
    }
    
    func getNextVC(after viewController: UIViewController?) -> UIViewController? {
        guard let viewController,
              let index = pages.firstIndex(of: viewController),
              index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
    
    func getPreviousVC(before viewController: UIViewController?) -> UIViewController? {
        guard let viewController,
              let index = pages.firstIndex(of: viewController),
              index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func moveToHome() {
        let viewController = HomeViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
    
    private func changeOnBoardingStatus() {
        if isFirstVC {
            onBoardingStatusLeading.setTitle("", for: .normal)
            onBoardingStatusTrailing.setTitle("Next", for: .normal)
        } else if isLastVC {
            onBoardingStatusLeading.setTitle("Back", for: .normal)
            onBoardingStatusTrailing.setTitle("Done", for: .normal)
        } else {
            onBoardingStatusLeading.setTitle("Back", for: .normal)
            onBoardingStatusTrailing.setTitle("Next", for: .normal)
        }
    }
}


// MARK: - Events
extension OnBoardingContainerViewController {
    @objc func onBoardingFinished() {
        moveToHome()
    }
    
    @objc func statusLeadingTapped() {
        guard let previousVC = getPreviousVC(before: currentVC),
              !isFirstVC else { return }
        currentVC = previousVC
        uiPageViewController.setViewControllers([previousVC], direction: .reverse, animated: true)
    }
    
    @objc func statusTrailingTapped() {
        if isLastVC {
            moveToHome()
        } else {
            guard let nextVC = getNextVC(after: currentVC) else { return }
            currentVC = nextVC
            uiPageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
        }
    }
}
