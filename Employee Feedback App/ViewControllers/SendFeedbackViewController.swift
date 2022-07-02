import UIKit

class SendFeedbackViewController: UIViewController {
    
    @IBOutlet var popButtonThree: UIButton!
    @IBOutlet var popButtonTwo: UIButton!
    @IBOutlet var popButtonOne: UIButton!
    @IBOutlet var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPopupButton()
    }
    
    func setPopupButton() {
        let optionClosure = {(action : UIAction) in print(action.title)}
        
        popButtonOne.menu = UIMenu(children : [
            UIAction(title : "1", state: .on, handler: optionClosure),
            UIAction(title : "2", handler: optionClosure),
            UIAction(title : "3", handler: optionClosure),
            UIAction(title : "4", handler: optionClosure),
            UIAction(title : "5", handler: optionClosure),])
        
        popButtonTwo.menu = UIMenu(children : [
            UIAction(title : "1", state: .on, handler: optionClosure),
            UIAction(title : "2", handler: optionClosure),
            UIAction(title : "3", handler: optionClosure),
            UIAction(title : "4", handler: optionClosure),
            UIAction(title : "5", handler: optionClosure),])
        
        popButtonThree.menu = UIMenu(children : [
            UIAction(title : "1", state: .on, handler: optionClosure),
            UIAction(title : "2", handler: optionClosure),
            UIAction(title : "3", handler: optionClosure),
            UIAction(title : "4", handler: optionClosure),
            UIAction(title : "5", handler: optionClosure),])
        
        popButtonOne.showsMenuAsPrimaryAction = true
        popButtonOne.changesSelectionAsPrimaryAction = true
        
        popButtonTwo.showsMenuAsPrimaryAction = true
        popButtonTwo.changesSelectionAsPrimaryAction = true
        
        popButtonThree.showsMenuAsPrimaryAction = true
        popButtonThree.changesSelectionAsPrimaryAction = true
    }
}
