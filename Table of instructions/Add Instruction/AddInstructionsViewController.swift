import UIKit
import Combine

class AddInstructionsViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!
    @IBOutlet var missionTextField: UITextField!
    
    var viewMadel: AddInstructionsViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBarButton()
        chooseWoker()
    }

    private func addNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(touchButtonSave))
    }
    
    private func chooseWoker() {
        
        viewMadel.publisherWorkers
            .map { workers in
                workers.map { worker in
                    UIAction(title: worker.name) {[weak self] action in
                        guard let self else { return }
                        button.setTitle(worker.name, for: .normal)
                        viewMadel.worker = worker
                    }
                }
            }
            .sink { [weak self] workers in
                guard let self else { return }
                
                let menu = UIMenu(title: "Выберите работника", children: workers)
                button.menu = menu
                button.showsMenuAsPrimaryAction = true
            }
            .store(in: &cancellables)
    }
    
    @objc private func touchButtonSave() {
        guard let missionText = missionTextField.text,
              let descriptionText = textField.text
        else { return }
        
        viewMadel.addTaskForWorker(mission: missionText, description: descriptionText) {[weak self] in
            let alert = UIAlertController(title: "Выберете работника", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self?.present(alert, animated: true)
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
