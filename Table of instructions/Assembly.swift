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
        
        conteiner.register(InstructionViewModel.self) { resolver in
            InstructionViewModel()
        }
        
        conteiner.storyboardInitCompleted(InstructionsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(InstructionViewModel.self)
        }
        
        return conteiner.synchronize()
        
    }
}
