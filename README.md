**Deployment target:**
Minimum Target: iOS(16)

**UI and Structure**
Design:
Base UIIkit app
SwiftUI Used in smaller views like TableViewCell

Navigation: Used Coordinator,
Architecture: MVVM with Clean Architecture (UseCase & Coordinator)

**Principals and Patterns:**
SOLID conformance:
Network layer using combine.
Features are separated into modules.
Repository for formatting backend data.
UseCases for business logic.
Observer pattern to bindViewModel data to view.
Coordinator to manage navigation & communication among modules.


Decisions Made is to build project using MVVM Clean Architecture for Maintainability and Scalability, Use Coordinator in navigation and pass dependencies in it's functions for more cleaner code and Conforming to DRY and SR & DI principles.

The Challanges encountered that it's the first time to use SwiftUI view as tableViewCell but it was interesting and challanging as i tried something new, I'm familir by the opposite is that to include UIView components in SWIFTUI, Passing data from viewModel to view should be done by listening to returned data but it requires to declare viewModel as @StateObject and add init in ViewController which requires more time to setup it, So i went through using bindables.  
