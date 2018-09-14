# FlickrImageSearch
This projects searches for images from flickr api and displays them in a 3-column grid and also uses pagination to display further image details

## Task
Mobile app that uses the Flickr image search API and shows the results in a 3-column scrollable view.
- The app must let users enter queries, such as "kittens".
- The app must support endless scrolling, automatically requesting and displaying
more images when the user scrolls to the bottom of the view.
- Do not use third-party libraries. They should not be needed for a project of this scale and we want to make sure you are familiar with the basics.

## Abstract
The app lets you search images based on keywords and displays it grid format with 3 cells in a row. The data is paginated and service takes care of fetching from Flickr service. MVVM architecture is used for app

## Class Details

### Views
- #### ViewController 
This is the primary class which consists of collection view and search text field. It also encapsulates functionality like fetching, refreshing and searching. On fetching data it binds this data with viewmodel and hence render it
- #### AlbumCollectionViewCell
This is the view which is reused for displaying images fetched from service. It also renders image by downloading it asyncronously using image fetcher and also handles some important usecase like cancelling downloading while recycling.

### Communicator
- #### NetworkCommunicator
This class will be basically used to fetch data from server. It is used to fetch data using http protocol like GET, POST. Has 2 methods on which fetches data as Data type or any Codable format.
- #### FlickrPaginatedAPIService
This service maintains state so that it can be used for fetching consecutive pages. It internally uses network communicator class for fetching data.

### Models
- #### FlickrResponse
This class represents the structure of response of every page from flicker service. Its is codable and hence used for parsing
- #### AlbumModel
This model represents data related to images been rendered. It encapsultes all related info and hence generates url for fetching images

#### ViewModel
GridViewModel represents data to be rendered in ViewController. AlbumCellViewModel represents data to be rendered in collection view cells, this is been generated while views are recycled.

### Utilities 
- #### ImageFetcher 
It is used for fetching images asyncronously and also setting images to imageview. Also takes care of stale requests which might not be relevent after recycling of view

- #### Observable 
Utility to monitor change of wrapped value can be useful incase we need to listen to change in values
