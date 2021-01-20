//
//  MapScreenController.swift
//  TestVertagelab
//
//  Created by Anna Luchechko on 20.01.2021.
//

import UIKit
import SnapKit
import GoogleMaps

class MapScreenController: UIViewController {

    lazy var googleMapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(), camera: camera)
        return mapView
    }()
    
    lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont(name: "Noteworthy", size: 20.0)
       return textField
   }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy", size: 20.0)
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        setupView()
        runSnapKitAutoLayout()
    }
    
    private func setupView() {
        view.addSubview(googleMapView)

    }
    
    private func runSnapKitAutoLayout() {
        googleMapView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.width)
            make.centerY.equalTo(view.snp.centerY).offset(-20.0)
            make.centerX.equalTo(view.snp.centerX)
        }
    }

}

