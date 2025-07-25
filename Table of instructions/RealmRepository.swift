import RealmSwift
import Combine

class RealmRepository {
    
    static let shared = RealmRepository()
    private init() {}
    
    var tasksPublished = CurrentValueSubject<[RealmTaskApi], Never>([])
    
    private let realm = try! Realm()
    
    func saveInRealm(mission: String, description: String, worker: Worker) {
        try! realm.write {
            let task = RealmTaskApi()
            task.textMission = mission
            task.textDescription = description
            task.worker.append(RealmWorkerApi(name: worker.name, firstName: worker.firstName, lastName: worker.lastName, workShop: worker.workshops.name))
            realm.add(task)
        }
        tasksPublished.send(getAllTasksFromRealm())
    }
    
    func getAllTasksFromRealm() -> [RealmTaskApi] {
        print(realm.objects(RealmTaskApi.self))

        return Array(realm.objects(RealmTaskApi.self))
    }
    
    func completeTask(task: RealmTaskApi) {
      try! realm.write {
            task.isCompleted.toggle()
        }
        tasksPublished.send(getAllTasksFromRealm())
    }
    
    func sortTasks(filter: FilterForTasks) {
    switch filter {
        case .all:
            tasksPublished.send(getAllTasksFromRealm())
        case .completion:
        //MARK: тут мне подсказал с двумя
            tasksPublished.send(getAllTasksFromRealm().filter { $0.isCompleted })
        case .nonCompletion:
            tasksPublished.send(getAllTasksFromRealm().filter { !$0.isCompleted })
        }
    }
    
}
