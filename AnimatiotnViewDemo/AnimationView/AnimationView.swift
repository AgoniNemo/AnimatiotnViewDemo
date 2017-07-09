//
//  AnimationView.swift
//  AnimatiotnViewDemo
//
//  Created by Nemo on 2017/7/9.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit


protocol AnimationViewDelegate:class {
    
    func animatedViewNumberOfImages(animationView:AnimationView) -> Int;
    
    func animatedView(animatedView:AnimationView,index:NSInteger) -> UIImage;
    
}

class AnimationView: UIView {

    private var imageViews:NSArray?;
    private var animating:Bool?;
    private var totalImages:Int?;
    private var currentlyDisplayingImageViewIndex:Int?;
    private var currentlyDisplayingImageIndex:Int?;
    
    
    
    var kAnimationViewDefaultTimePerImage = 20.0;
    var noImageDisplayingIndex = -1;
    var imageSwappingAnimationDuration = 2.0;
    var imageViewsBorderOffset = 150.0;
    
    open func startAnimating(){
        
        print(animating ?? Bool());
        if (animating == nil || animating == false) {
            animating = true;
            print(self.imageSwappingTimer);
            self.imageSwappingTimer.fire();
        }
    }
    
    open func stopAnimating(){
        
        if (self.animating == true) {
            imageSwappingTimer.fireDate = NSDate.distantPast;
            UIView.animate(withDuration: imageSwappingAnimationDuration, delay: 0.0, options: .beginFromCurrentState, animations: {
                for imageView in self.imageViews!{
                    let img = imageView as! UIImageView;
                    img.alpha = 0.0;
                }
            }, completion: { (finished:Bool) in
                self.currentlyDisplayingImageIndex = self.noImageDisplayingIndex;
                self.animating = false;
            });
        }
    }
    
    func bringNextImage(){
        
        let hide = self.imageViews?.object(at: currentlyDisplayingImageViewIndex!);
        let imageViewToHide = hide as! UIImageView;
        
        currentlyDisplayingImageViewIndex =
            (currentlyDisplayingImageViewIndex == 0) ? 1 : 0;
        
        
        let show = self.imageViews?.object(at: currentlyDisplayingImageViewIndex ?? Int());
        let imageViewToShow = show as! UIImageView;
        
        var nextImageToShowIndex = 0;
        
        repeat {
            //            print("total",totalImages ?? Int());
            nextImageToShowIndex = AnimationView.self.randomIntBetweenNumber(minNumber: 0, maxNumber: (totalImages ?? Int())-1);
            
        }while(nextImageToShowIndex == currentlyDisplayingImageIndex);
        
        currentlyDisplayingImageIndex = nextImageToShowIndex;
        
        //        print("nextImageToShowIndex",nextImageToShowIndex);
        
        imageViewToShow.image = self.delegate?.animatedView(animatedView: self, index: nextImageToShowIndex);
        
        let  kMovementAndTransitionTimeOffset = 0.1;
        
        UIView.animate(withDuration: self.timePerImage + imageSwappingAnimationDuration +
            kMovementAndTransitionTimeOffset, delay: 0.0, options: [.beginFromCurrentState,.curveLinear], animations: {
                let randomTranslationValueX = Double(self.imageViewsBorderOffset) * 3.5 - Double(AnimationView.self.randomIntBetweenNumber(minNumber: 0, maxNumber: Int(self.imageViewsBorderOffset)));
                //                print("x:",randomTranslationValueX);
                let translationTransform = CGAffineTransform(translationX:CGFloat(randomTranslationValueX), y:0);
                let result: Int  = AnimationView.self.randomIntBetweenNumber(minNumber: 115, maxNumber: 120);
                
                let randomScaleTransformValue: CGFloat = CGFloat(result) / 100;
                //                print("result:",(randomScaleTransformValue));
                let scaleTransform = CGAffineTransform(scaleX:randomScaleTransformValue, y:randomScaleTransformValue);
                
                imageViewToShow.transform = scaleTransform.concatenating(translationTransform);
                
        }, completion: nil);
        
        UIView.animate(withDuration: imageSwappingAnimationDuration, delay: kMovementAndTransitionTimeOffset, options: [.beginFromCurrentState,.curveLinear], animations: {
            
            imageViewToShow.alpha = 1.0;
            imageViewToHide.alpha = 0.0;
            
        }, completion: { (finished:Bool) in
            if (finished) {
                imageViewToHide.transform = CGAffineTransform.identity;
            }
        });
        
    }
    
    func reloadData(){
        totalImages = self.delegate?.animatedViewNumberOfImages(animationView: self);
        
        self.imageSwappingTimer.fire();
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self._init();
    }
    
    func _init(){
        let images = NSMutableArray.init();
        for _ in 0 ..< 2 {
            
            let frame = CGRect.init(x:(CGFloat)(-imageViewsBorderOffset*3.3), y: (CGFloat)(-imageViewsBorderOffset), width: self.bounds.size.width +
                (CGFloat)(imageViewsBorderOffset * 2), height: self.bounds.size.height +
                    (CGFloat)(imageViewsBorderOffset * 2));
            let imageView = UIImageView.init(frame:frame);
            imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
            imageView.clipsToBounds = false;
            imageView.contentMode = .scaleAspectFill;
            self.addSubview(imageView);
            
            images.add(imageView);
        }
        
        self.imageViews = NSArray.init(array: images);
        currentlyDisplayingImageIndex = noImageDisplayingIndex;
        
        currentlyDisplayingImageViewIndex = 0;
    }
    
    
    class func randomIntBetweenNumber(minNumber:Int,maxNumber:Int) -> Int {
        if minNumber > maxNumber {
            return self.randomIntBetweenNumber(minNumber: maxNumber, maxNumber: minNumber);
        }
        
        let result = UInt32(Int(maxNumber) - (minNumber) + Int(1));
        let arc = arc4random() % result
        
        let i = arc+UInt32(minNumber);
        //        print("i",i);
        
        return Int(i);
    }
    
    
    
    lazy var imageSwappingTimer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: self.timePerImage, target: self, selector:#selector(bringNextImage), userInfo: nil, repeats: true);
        return timer;
    }();
    
    lazy var timePerImage: TimeInterval = {
        return self.kAnimationViewDefaultTimePerImage;
        
    }();
    
    
    var delegate:AnimationViewDelegate?{
        
        didSet{
            totalImages = self.delegate?.animatedViewNumberOfImages(animationView: self);
        }
    }
    
    deinit {
        self.imageSwappingTimer.invalidate();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
