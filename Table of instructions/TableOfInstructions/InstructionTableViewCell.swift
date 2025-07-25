import UIKit

class InstructionTableViewCell: UITableViewCell {
    
    
    @IBOutlet var missionLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var statusLabel: UILabel!
    
    
    func fillTable(task: RealmTaskApi) {
        
        missionLabel.text = task.textMission
        descriptionLabel.text = task.textDescription
        statusLabel.text = task.isCompleted ? "Выполнено" : "В процессе"
    }
}
