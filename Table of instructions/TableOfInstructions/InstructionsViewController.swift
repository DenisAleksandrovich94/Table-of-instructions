import UIKit
import Combine
import SwinjectStoryboard

class InstructionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
     
    @IBOutlet var instructionsTableView: UITableView!
    @IBOutlet var filterButton: UIButton!
    
    var viewModel: InstructionViewModel!
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsTableView.dataSource = self
        instructionsTableView.delegate = self
        addNavigationBarButtonAndFilterButton()
        setupBindings()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionTableViewCell") as! InstructionTableViewCell
        cell.fillTable(task: viewModel.tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
               
        let checkTask = UIContextualAction(style: .normal, title: "Task") {[weak self] contextualAction, view, bool in
           guard let self else {return}
            viewModel.completionTask(task: viewModel.tasks[indexPath.row])
            bool(true)
        }
        
        checkTask.image = viewModel.tasks[indexPath.row].isCompleted ? UIImage(named: "chooiseCircle") : UIImage(named: "circle")

        let swipeActions = UISwipeActionsConfiguration(actions: [checkTask])

        return swipeActions
    }
    
    private func alertFilter() {
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        
        let alltask = UIAlertAction(title: "All task", style: .default) { [weak self] action in
            print("all task")
            self?.viewModel.sortTask(filter: .all)
        }
        let completedTask = UIAlertAction(title: "completed Task", style: .default) { [weak self] action in
            print("completed Task")
            self?.viewModel.sortTask(filter: .completion)

        }
        let inProgressTask = UIAlertAction(title: "progress Task", style: .default) { [weak self] action in
            print("progress Task")
            self?.viewModel.sortTask(filter: .nonCompletion)

        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
       
        alert.addAction(alltask)
        alert.addAction(completedTask)
        alert.addAction(inProgressTask)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    
    func addNavigationBarButtonAndFilterButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openVc))
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
    }
    
    @objc private func filterButtonAction() {
        alertFilter()
    }
    
    @objc private func openVc() {
        let newVc = SwinjectStoryboard.create(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddInstructionsViewController")
        navigationController?.pushViewController(newVc, animated: true)
    }
    
    private func setupBindings() {
        viewModel.$tasks
        //MARK: почему без очереди обновлялось с задержкой
            .receive(on: DispatchQueue.main)
            .sink { [self] tasks in
            instructionsTableView.reloadData()
        }
        .store(in: &cancellable)
    }

}

