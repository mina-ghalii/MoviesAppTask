
import UIKit

class Alert: NSObject {
    
    
    typealias MethodHandler2 = ()  -> Void


    class   func show(title : String , cancelTitle : String , otherTitles : [String], completion :@escaping (_ index : Int) -> Void)  {
        
        let alertController = UIAlertController.init(title: "", message: title, preferredStyle: .alert)

        
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action) in
            completion(0)
            
        })
        alertController.addAction(cancelAction)
        
        
        for string in otherTitles {
            
            let action = UIAlertAction.init(title: string, style: .default, handler: { (action) in
                
                completion(otherTitles.firstIndex(of: string)! + 1)
                
            })
            alertController.addAction(action)
            
        }
        
       
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        
    }
    class func show(message : String)  {
        
        Alert.show(title: message, cancelTitle: "OK", otherTitles: []) { (index) in
            
        }
        
    }
}

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
