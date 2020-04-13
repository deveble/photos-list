//
//  PhotoHeroVC.swift
//  photosList
//
//  Created by User on 2/14/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit
import Hero

class PhotoHeroVC: UIViewController {
    
    // MARK: - Properties
    var heroImage: UIImage?
    private var isTouched = true
    private var scrollView: UIScrollView!
    private var photoImageView: UIImageView!
    private var tapGesture: UITapGestureRecognizer!
    private var doubleTapGesture: UITapGestureRecognizer!
    private var dismissGesture: UIPanGestureRecognizer!
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        showHideOverlays(withDelay: 0.5)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillLayoutSubviews() {
        centerScrollViewIfNeeded()
    }
    private func configureViewController() {
        guard let heroImage = heroImage else {
            fatalError("Hero image found nil")
        }
        self.hero.isEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting:.zoom, dismissing:.zoomOut)
        
        configureScrollView()
        configurePhotoImageView()
        configureTapGestures()
        configureDismissGesture()
        configureContentSize(withHeight: getImageSizeHeight(image: heroImage))
    }
    private func getImageSizeHeight(image: UIImage) -> CGFloat {
        let size = image.size
        let height = size.height
        let width = size.width
        return height * UIScreen.main.bounds.width / width
    }
    
    private func configureTapGestures() {
        tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(showHideOverlays(withDelay:)))
        
        tapGesture.addTarget(self,
                             action: #selector(zoomOut))
        
        doubleTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(zoomInOut(gestureRecognizer:)))
        
        doubleTapGesture.addTarget(self,
                                   action: #selector(hideOverlays))
        
        tapGesture.numberOfTapsRequired = 1
        doubleTapGesture.numberOfTapsRequired = 2
        
        tapGesture.delegate = self
        doubleTapGesture.delegate = self
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(doubleTapGesture)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3
        scrollView.contentMode = .center
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configurePhotoImageView() {
        photoImageView = UIImageView(frame: view.bounds)
        photoImageView.image = heroImage
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.heroID = "Hero"
        scrollView.addSubview(photoImageView)
    }
    
    private func configureContentSize(withHeight height: CGFloat) {
        let bounds = view.bounds
        scrollView.frame = bounds
        let size = CGSize(
            width: UIScreen.main.bounds.width,
            height: height
        )
        photoImageView.frame = CGRect(origin: .zero, size: size)
        scrollView.contentSize = size
    }
    
    private func configureDismissGesture() {
        dismissGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissController))
        view.addGestureRecognizer(dismissGesture)
    }
    
    private func zoomRect(forScale scale: CGFloat, withCenter center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = photoImageView.frame.size.height / scale
        zoomRect.size.width  = photoImageView.frame.size.width  / scale
        let newCenter = photoImageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    private func centerScrollViewIfNeeded() {
        var inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if scrollView.contentSize.height < scrollView.bounds.height {
            let insetV = (scrollView.bounds.height - scrollView.contentSize.height)/2
            inset.top += insetV
            inset.bottom = insetV
        }
        if scrollView.contentSize.width < scrollView.bounds.width {
            let insetV = (scrollView.bounds.width - scrollView.contentSize.width)/2
            inset.left = insetV
            inset.right = insetV
        }
        scrollView.contentInset = inset
    }
    
    @objc private func showHideOverlays(withDelay delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                if self.isTouched {
                    //                    self.statsContainerViewBottomConstraint.constant = 0
                    //                    self.dismissButtonTopConstraint.constant = 16
                    self.isTouched = false
                } else {
                    self.hideOverlays()
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func hideOverlays() {
        //        self.statsContainerViewBottomConstraint.constant = 132
        //        self.dismissButtonTopConstraint.constant = -100
        self.isTouched = true
    }
    
    @objc private func zoomInOut(gestureRecognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(
                to: zoomRect(
                    forScale: scrollView.maximumZoomScale,
                    withCenter: gestureRecognizer.location(in: gestureRecognizer.view)),
                animated: true)
        } else {
            zoomOut()
        }
    }
    
    @objc private func zoomOut() {
        scrollView.setZoomScale(1, animated: true)
    }
    
    @objc private func dismissController() {
        if scrollView.zoomScale > 1 { return }
        
        let translation = dismissGesture.translation(in: nil)
        let progress = abs(translation.y / view.bounds.height) * 1.5
        switch dismissGesture.state {
        case .began:
            Hero.shared.defaultAnimation = .fade
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(progress)
            let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: photoImageView)
        default:
            if progress + dismissGesture.velocity(in: nil).y / view.bounds.height > 0.3 {
                Hero.shared.finish()
            } else {
//                dismiss(animated: true, completion: nil)
                Hero.shared.cancel()
            }
        }
    }
}

// MARK: UIScrollViewDelegate

extension PhotoHeroVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewIfNeeded()
    }
}

// MARK: PhotoDetailsViewController

extension PhotoHeroVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return gestureRecognizer == self.tapGesture &&
            otherGestureRecognizer == self.doubleTapGesture
    }
}

