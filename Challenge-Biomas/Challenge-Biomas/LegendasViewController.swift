//
//  LegendasViewController.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/16/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

final class LegendasViewController: UIViewController {
    
    lazy var viewzinha: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        let frame = UIScreen.main.bounds
        view.frame = CGRect(x: (frame.width / 2) - 20, y: frame.minY + 10,
                            width: 40, height: 8)
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    
    
    lazy var segmentedControll: UISegmentedControl = {
        
        let items = ["Biomas" , "Desmatamento"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
        let frame = UIScreen.main.bounds
        customSC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 50,
                                width: frame.width - 20, height: 32)
        
        
        customSC.layer.cornerRadius = 5.0
//        customSC.backgroundColor = UIColor.black
        customSC.selectedSegmentTintColor = UIColor.init(named: "tintButton")
        customSC.addTarget(self, action: #selector(LegendasViewController.changeColor(sender:)), for: .valueChanged)
        
        return customSC
    }()

    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    lazy var biomas: GroupLegendsView = {
        let view = GroupLegendsView()
        return view
    }()
    
    lazy var desmatamento: GroupLegendsView = {
        let view = GroupLegendsView()
        return view
    }()
    
    
    
    let menuView = UIView()
    let menuHeight = UIScreen.main.bounds.height / 2.5
    var isPresenting = false
    
    //delegate foi indicado como var weak logo o protocolo deve se class
    weak var delegate: LegendasViewDelegate?
    
    init(delegate: LegendasViewDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(menuView)
    
        
        
        menuView.backgroundColor = .white
        print("TA SUBIIIIINDO TIO")
        
        menuView.layer.cornerRadius = 15
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LegendasViewController.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        
        self.menuView.addSubview(segmentedControll)
        self.menuView.addSubview(viewzinha)
        
        self.menuView.addSubview(biomas)
        self.menuView.addSubview(desmatamento)
        print(menuView)
        
        setupSegmented()
        
        setupGroupedItem(&biomas)
        setupGroupedItem(&desmatamento)
        
        segmentedControll.sendActions(for: .valueChanged)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    //
    @objc func changeColor(sender: UISegmentedControl) {

        print("selected \(sender.selectedSegmentIndex)")

        switch sender.selectedSegmentIndex {
        case 0:
            biomas.isHidden = false
            desmatamento.isHidden = true
            
        case 1:
            biomas.isHidden = true
            desmatamento.isHidden = false
        default:
            break
        }
        
        switch sender.selectedSegmentIndex {
        case 1:
            self.delegate?.exibir(.estados)
        default:
            self.delegate?.exibir(.bioma)
        }

    }
    
    func setupSegmented() {
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControll.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor, constant: 20),
            segmentedControll.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor, constant: -20),
            segmentedControll.topAnchor.constraint(equalTo: self.viewzinha.bottomAnchor, constant: 20),
            segmentedControll.centerXAnchor.constraint(equalTo: self.menuView.centerXAnchor)
        ])
    }
    
    func setupGroupedItem(_ view: inout GroupLegendsView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.segmentedControll.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.segmentedControll.bottomAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: self.segmentedControll.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: -20)
        ])
    }
    
    
    

}



extension LegendasViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        guard let destination = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        isPresenting.toggle()
        
        switch isPresenting {
        case true:
            container.addSubview(destination.view)
            menuView.frame.origin.y += menuHeight
            backdropView.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        case false:
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
        
    }
}

