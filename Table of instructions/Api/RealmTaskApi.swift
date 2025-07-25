import RealmSwift

class RealmTaskApi: Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var textMission = String()
    @Persisted var textDescription = String()
    @Persisted var isCompleted = false
    @Persisted var worker: List<RealmWorkerApi>
}

class RealmWorkerApi: Object {
    @Persisted var name: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var workShop: String
    @Persisted(originProperty: "worker") var tasks: LinkingObjects<RealmTaskApi>
    
    convenience init(name: String, firstName: String, lastName: String, workShop: String) {
        self.init()
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.workShop = workShop
        
    }
    
    
}
