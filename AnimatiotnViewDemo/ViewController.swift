//
//  ViewController.swift
//  AnimatiotnViewDemo
//
//  Created by Nemo on 2017/7/9.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,AnimationViewDelegate{
    
    var  userTF:LineTextField?;

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.view.backgroundColor = UIColor.white;
        
        self.view.addSubview(self.animationView);
        
        
        let x = 50;
        userTF = LineTextField.init(frame: XCGRect(x: CGFloat(x), y: SCREEN_HEIGH/2+50, width: SCREEN_WIDTH-CGFloat(x)*2, height: 20));
        userTF?.placeholder(color:UIColor.white,string:"账号");
        
        userTF?.leftView = UIImageView.init(image: #imageLiteral(resourceName: "email"))
        userTF?.leftViewMode = UITextFieldViewMode.always;
        userTF?.delegate = self;
        self.view.addSubview(userTF!);
        
        let passTF = LineTextField.init(frame: XCGRect(x: CGFloat(x), y: (userTF?.frame.maxY)!+20, width: SCREEN_WIDTH-CGFloat(x)*2, height: 20));
        passTF.placeholder(color:UIColor.white,string:"密码");
        passTF.leftView = UIImageView.init(image: #imageLiteral(resourceName: "password"))
        passTF.leftViewMode = UITextFieldViewMode.always;
        self.view.addSubview(passTF);
        
        let btn = UIButton.init(type: UIButtonType.system);
        btn.frame = XCGRect(x: CGFloat(x), y: passTF.frame.maxY+20, width: passTF.frame.width, height: 40);
        btn.setTitle("登录", for: UIControlState.normal);
        btn.setTitleColor(UIColor.white, for: UIControlState.normal);
        btn.backgroundColor = HOMECOLOR;
        btn.alpha = 0.8;
        btn.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside);//#selector(btnClick(_:))
        self.view.addSubview(btn);
        
    }
    /**
     func btnClick(_ button:UIButton){
     
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.animationView.startAnimating();
    }
    func animatedViewNumberOfImages(animationView: AnimationView) -> Int {
        return 2;
    }
    func animatedView(animatedView: AnimationView, index: NSInteger) -> UIImage {
        return #imageLiteral(resourceName: "login_back");
    }
    func btnClick(){
        self.animationView.stopAnimating();
        print("login");
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userTF {
            UIView.animate(withDuration: 0.25, animations: {
                
            })
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    lazy var animationView:AnimationView = {
        
        let animatedView = AnimationView.init(frame: XCGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGH));
        animatedView.delegate = self;
        animatedView.startAnimating();
        
        return animatedView;
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

