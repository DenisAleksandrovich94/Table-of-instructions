import UIKit
import Combine

class AddInstructionsViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!
    
    var viewMadel: AddInstructionsViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBarButton()
        chooseWoker()
    }

    private func addNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(сloseVc))
    }
    
    private func chooseWoker() {
        
        viewMadel.publisherWorkers
            .map { workers in
                workers.map { worker in
                    UIAction(title: worker.name) {[weak self] action in
                        self?.button.setTitle(worker.name, for: .normal)
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
    
    @objc private func сloseVc() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
