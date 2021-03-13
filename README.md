# Space Flight News
Task: to retrieve titles for space flight related news and displays something received on the screen once user somehow triggers retrieval.

# Technical Solutions  
  
**Architecture**  
  
In this project I followed MVС architecture approach.

`Model` in my project is presented by a `repository`, which receives the query from `controller` to get list of news.

`Repository` sends the fetch request to the `network` a.k.a `SpaceFlightNewsApi`. 
  
The `SpaceFlightNewsApi` module contains code working with the backend.


**Models**  
  
The `Model` module contains `data` models. 

**Code Style**

`SwiftLint` is integrated into Xcode to follow Swift style and conventions.

## Features


## Limitations


## Requirements

* Swift 5.0
* Xcode 12.2
* iOS 14.1+
