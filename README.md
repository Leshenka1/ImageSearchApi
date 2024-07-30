# ImageSearchAPI
## Project description
The ImageSearchAPI application allows users to search for images on demand using the Pixabay API. The application provides a convenient interface for entering search queries, setting the number of images and columns to display results. All results are displayed in a grid of images that can be viewed in real time.

## Program benefit
### 1. Users can customize the number of images to be fetched and the number of columns in the grid layout.

This is achieved through the Settings view, where users can adjust these parameters. The ImageSearchSettings class holds these settings, and they are applied across the application. The user can request up to 200 photos (API restriction) and up to 5 columns (for viewing convenience).

### 2. Image search operations are performed asynchronously, ensuring a responsive and smooth user experience.

The ImageSearchViewModel class handles the search logic using Swift's async/await features. The actual network request is performed using URLSession with a timeout to handle slow network conditions gracefully.

### 3. The application automatically detects the language(ru/en) of the search query and fetches relevant results accordingly.

The ImageSearchViewModel includes a detectLanguage(for:) function that uses CFStringTokenizerCopyBestStringLanguage to determine the language of the query. The detected language is then used in the API request to fetch localized results.

### 4. The ImageSearchAPI application follows the MVVM (Model-View-ViewModel) architecture, which separates the business logic, UI, and data binding into distinct layers.

### 5. The application validates input search queries to ensure they are not empty and properly formatted. 
   
## Build and launch the application
To build and run the application you need to clone the repository and open the project using xcode. Launch the project in xcode. No additional libraries are required.

## Project structure
- ImageModel.swift: Defines the data structures for storing images.
- ContentView.swift: The main view of an application, containing the logic for displaying and interacting with the user.
- Settings.swift: View to configure search and represantation parameters.
- ImageCell.swift: Cell for displaying a single image.
- ImageGrid.swift: Grid to display search results.
- SearchBar.swift: Search field for entering queries.
- ImageSearchSettings.swift: Application configuration storage model.
- ImageSearchViewModel.swift: The model of the presentation for searching and processing results.

## App views
<img width="254" alt="изображение" src="https://github.com/user-attachments/assets/ba6138df-984d-43e9-aa0a-e024bd425ad5">
<img width="256" alt="изображение" src="https://github.com/user-attachments/assets/6b6b986e-06f3-4a21-b42e-9f6a4784d550">

## Test results
<img width="300" alt="изображение" src="https://github.com/user-attachments/assets/53eb903d-fe5a-4051-9c84-b58e965b686c">



