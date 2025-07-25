import Swinject
import SwinjectStoryboard

class Assembly {
    
    func addAssembly() -> Resolver {
        let conteiner = Container()
        SwinjectStoryboard.defaultContainer = conteiner
        
        conteiner.register(DataWorkers.self) { resolver in
            DataWorkers()
        }
        .inObjectScope(.container)
        
        conteiner.register(AddInstructionsViewModel.self) { resolver in
            AddInstructionsViewModel(dataWorkers: resolver.resolve(DataWorkers.self)!)
        }
       
        conteiner.storyboardInitCompleted(AddInstructionsViewController.self) { resolver, controller in
            controller.viewMadel = resolver.resolve(AddInstructionsViewModel.self)
        }
        return conteiner.synchronize()
        
    }
}
