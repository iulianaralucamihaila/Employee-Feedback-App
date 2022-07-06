import UIKit

var myActivityIndicator = UIActivityIndicatorView()
extension UIViewController {
    func showActivityIndicator() {
        // Create activity indicator
        myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center

        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true

        // Start Activity Indicator
        myActivityIndicator.startAnimating()

        view.addSubview(myActivityIndicator)
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
