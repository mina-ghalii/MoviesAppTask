
import UIKit
import PKHUD

class Hud: NSObject {
    
    class func show(on controller : UIViewController)  {
        let bluredView:UIVisualEffectView=PKHUD.sharedHUD.contentView.superview?.superview as! UIVisualEffectView
        bluredView.backgroundColor=UIColor.clear
        bluredView.effect=nil
        if let top = controller.navigationController {
            HUD.show(.rotatingImage(#imageLiteral(resourceName: "loadingImage")), onView: top.view)
        } else if let top = controller.tabBarController  {
            HUD.show(.rotatingImage(#imageLiteral(resourceName: "loadingImage")), onView: top.view)
        } else {
            HUD.show(.rotatingImage(#imageLiteral(resourceName: "loadingImage")), onView: controller.view)
        }
    }
    class func showLoading()  {

        HUD.show(.progress)
    }
    
    class func hideLoading()  {
        PKHUD.sharedHUD.hide()
    }
    
    class func hide(from controller : UIViewController)  {
        PKHUD.sharedHUD.hide()
    }

}
