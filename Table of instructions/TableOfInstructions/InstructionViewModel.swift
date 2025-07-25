import UIKit
import Combine

class InstructionViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var tasks = [RealmTaskApi]()
    
    init() {
        
        RealmRepository.shared.tasksPublished.sink { [weak self] tasks in
            guard let self else { return }
            self.tasks = tasks
        }
        .store(in: &cancellables)
        tasks = RealmRepository.shared.getAllTasksFromRealm()

    }
    
    func completionTask(task: RealmTaskApi) {
        RealmRepository.shared.completeTask(task: task)
    }
    
    func sortTask(filter: FilterForTasks) {
        RealmRepository.shared.sortTasks(filter: filter)
    }
}
