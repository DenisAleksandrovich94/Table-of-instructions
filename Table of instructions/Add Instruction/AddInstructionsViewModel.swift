import UIKit
import Combine

class AddInstructionsViewModel {
   
    var publisherWorkers = CurrentValueSubject<[Worker], Never>([])
    var dataWorkers: DataWorkers

    init(dataWorkers: DataWorkers) {
        self.dataWorkers = dataWorkers
        getWorkers()
    }
    
   private func getWorkers() {
       publisherWorkers.send(dataWorkers.workers)
    }
}
