import UIKit
import SwinjectStoryboard

class InstructionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
     
    @IBOutlet var instructionsTableView: UITableView!
    
    var isActive = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsTableView.dataSource = self
        instructionsTableView.delegate = self
        addNavigationBarButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionTableViewCell") as! InstructionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let filterAction = UIContextualAction(style: .normal, title: "Filter") { [weak self] (contextualAction, view, boolValue) in
            self?.alertFilter()
            boolValue(true)
        }
               
        let checkTask = UIContextualAction(style: .normal, title: "Task") {[weak self] contextualAction, view, bool in
           guard let self else {return}
            
            isActive.toggle()
            //MARK: Это не работало, зачем нужен этот action and view,  и когда нужно reloadrows
//            let newImage = isActive
//            ? UIImage(named: "chooiseCircle")
//            : UIImage(named: "circle")
//                
//            contextualAction.image = newImage
//            tableView.reloadRows(at: [indexPath], with: .none)
//            
            bool(true)
        }
        
        checkTask.image = isActive ? UIImage(named: "chooiseCircle") : UIImage(named: "circle")

        let swipeActions = UISwipeActionsConfiguration(actions: [checkTask, filterAction])

        return swipeActions
    }
    
    private func alertFilter() {
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        
        let alltask = UIAlertAction(title: "All task", style: .default) { action in
            print("all task")
        }
        let completedTask = UIAlertAction(title: "completed Task", style: .default) { action in
            print("completed Task")
        }
        let inProgressTask = UIAlertAction(title: "progress Task", style: .default) { action in
            print("progress Task")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
       
        alert.addAction(alltask)
        alert.addAction(completedTask)
        alert.addAction(inProgressTask)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    
    func addNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openVc))
    }
    
    @objc private func openVc() {
        let newVc = SwinjectStoryboard.create(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddInstructionsViewController")
        navigationController?.pushViewController(newVc, animated: true)
    }

}

