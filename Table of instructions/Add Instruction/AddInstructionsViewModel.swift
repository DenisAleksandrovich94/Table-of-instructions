import UIKit
import Combine

class AddInstructionsViewModel {
   
    var publisherWorkers = CurrentValueSubject<[Worker], Never>([])
    var dataWorkers: DataWorkers
    var worker: Worker!
     

    init(dataWorkers: DataWorkers) {
        self.dataWorkers = dataWorkers
        getWorkers()
    }
    
   private func getWorkers() {
       publisherWorkers.send(dataWorkers.workers)
    }
    
    func addTaskForWorker(mission: String, description: String, error: @escaping () -> ()) {
        guard worker != nil else { return error() }
        RealmRepository.shared.saveInRealm(mission: mission, description: description, worker: worker)
        
    }
}
