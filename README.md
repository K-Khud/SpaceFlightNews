# Space Flight News
Task: to retrieve titles for space flight related news and displays something received on the screen once user somehow triggers retrieval.

# Technical Solutions  
  
**Architecture**  

`Model` contains files to decode a network response in JSON format.

`Repository` sends the fetch request to the `network` a.k.a `SpaceFlightNewsApi`, it receives the query from `controller` to get list of news and images. 
  
The `SpaceFlightNewsApi` module contains code working with the backend.

`SpaceCollectionViewController` is a UICollectionViewController that is responsible for app's UI.

**Code Style**

`SwiftLint` is integrated into Xcode to follow Swift style and conventions.

## Unit tests

`Mocks` contains the mocks of classes that are useful for the unit tests.

`SpaceFlightNewsModelTests` covers the implementation of Equitable protocol.

`SpaceFlightNewsRepositoryTests` tests JSON parsing, encoding and decoding methods.

`SpaceFlightNewsApiServiceTest` contains methods that tests getting valid data from the network.

`SpaceFlightNewsViewControllerTests` tests the method that sends request for uploading an image.

## Additional Features

The alert is added for the case of empty backend response to send the fetch request again.

## Limitations

The initial task did not require to pay much attention on GUI or usability. 
In future I would add a method to resize received image, since the current size slows down UI.

## Requirements

* Swift 5.0
* Xcode 12.4
* iOS 14.4+
