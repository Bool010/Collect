//
//  WNHalfwayPresentationController.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/5.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNHalfwayPresentation: UIPresentationController {
    
    var isPresenting = false
    var dimmingView: UIVisualEffectView!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        if isPresenting {
            let view = presentingViewController.view
            view?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            var frame = view?.frame
            frame?.origin.x = (self.containerView?.frame.maxX)! * 0.05
            frame?.origin.y = (self.containerView?.frame.maxY)! * 0.05
            view?.frame = frame!
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        return CGRect.init(x: 0, y: bounds.maxY / 2, width: bounds.width, height: bounds.maxY / 2)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        isPresenting = true
        dimmingView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
        dimmingView.alpha = 0.0
        self.containerView?.insertSubview(dimmingView, aboveSubview: presentingViewController.view)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        isPresenting = false
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        UIApplication.shared.keyWindow?.addSubview(presentingViewController.view)
        dimmingView.removeFromSuperview()
    }
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    deinit {
        wn_deinitMessage("WNHalfwayPresentation")
    }
}



// MARK: - UIViewControllerTransitioningDelegate
extension WNHalfwayPresentation: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}



// MARK: - UIViewControllerAnimatedTransitioning
extension WNHalfwayPresentation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            presentAnimation(transitionContext)
        } else {
            dismissAnimation(transitionContext)
        }
    }
    
    private func presentAnimation(_ context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        containerView.backgroundColor = .black
        let duration = self.transitionDuration(using: context)
        
        // From
        let fromBoard = presentingViewController
        let fromView = fromBoard.view
        containerView.addSubview(fromView!)
        
        // To
        let toBoard = presentedViewController
        let toView = toBoard.view
        var toInitialFrame = context.initialFrame(for: toBoard)
        let toFinalFrame = context.finalFrame(for: toBoard)
        toInitialFrame.origin = CGPoint.init(x: containerView.bounds.minX,
                                             y: containerView.bounds.maxY)
        toInitialFrame.size = toFinalFrame.size
        toView?.frame = toInitialFrame
        toView?.alpha = 0.0
        toView?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        containerView.addSubview(toView!)
        
        fromBoard.view.isUserInteractionEnabled = false
        
        // Animation
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3, options: [], animations: { [weak self] in
            
            guard let _self = self else { return }
            _self.dimmingView.alpha = 0.5
            
            toView?.transform = CGAffineTransform.identity
            toView?.frame = toFinalFrame
            toView?.alpha = 1
            
            fromView?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            var frame = fromView?.frame
            frame?.origin.x = containerView.frame.maxX * 0.05
            frame?.origin.y = containerView.frame.maxY * 0.05
            fromView?.frame = frame!
        }) { (_) in
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    private func dismissAnimation(_ context: UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        let duration = self.transitionDuration(using: context)
        
        // From
        let fromBoard = presentedViewController
        let fromView = fromBoard.view
        var fromFinalFrame = context.initialFrame(for: fromBoard)
        fromFinalFrame = (fromView?.frame)!
        fromFinalFrame.origin.y = containerView.frame.maxY
        
        // To
        let toBoard: UIViewController = presentingViewController
        let toView = toBoard.view
        let toFinalFrame = CGRect.init(x: 0.0, y: 0.0, width: (self.containerView?.frame.maxX)!, height: (self.containerView?.frame.maxY)!)
        
        // Animation
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3, options: [], animations: { [weak self] in
            
            guard let _self = self else { return }
            _self.dimmingView.alpha = 0.0
            
            fromView?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            fromView?.frame = fromFinalFrame
            
            toView?.transform = CGAffineTransform.identity
            toView?.frame = toFinalFrame
            
        }) { [weak self] (_) in
            guard let _self = self else { return }
            let wasCancelled = context.transitionWasCancelled
            if !wasCancelled {
                _self.presentingViewController.view.isUserInteractionEnabled = true
            }
            context.completeTransition(!wasCancelled)
        }
    }
}
