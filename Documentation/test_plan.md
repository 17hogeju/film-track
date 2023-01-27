# Test Plan

## Overall Test Plan

Our testing approach will assess the functionality and performance of our app for several individual components and various integrated systems. We will use a set of real media data to perform CRUD operations in our database. We will create various profiles to test authorization and access rights. Our algorithms will be tested on their performance of using metadata to group and sort media titles and subscription services. Finally, we will test the flexibility of our UI by adjusting the placement of components in the code.

## Test case Descriptions

DB1.1 Firebase Database Test 1  
DB1.2 This test will ensure that write operations from the mobile application will write instantly to the Firebase Realtime Database.  
DB1.3 We will add media to a user’s “To Watch” list and verify that the information in the correct format.  
DB1.4 Inputs: Media (movies, tv shows)  
DB1.5 Outputs: Data in the Firebase Realtime Database  
DB1.6 Normal  
DB1.7 Whitebox  
DB1.8 Functional  
DB1.9 Integration  

DB2.1 Firebase Database Test 2  
DB2.2 This test will ensure that read queries from the mobile application will return up-to-date data from the Firebase Realtime Database.  
DB2.3 We will attempt to view a user’s subscriptions from the app and verify that the subscriptions show up.  
DB2.4 Inputs: Read query for subscriptions  
DB2.5 Outputs: Subscriptions  
DB2.6 Normal  
DB2.7 Blackbox  
DB2.8 Functional  
DB2.9 Integration  

DB3.1 Firebase Database Test 3  
DB3.2 This test will ensure that update operations from the mobile application will update instantly in the Firebase Realtime Database.  
DB3.3 We will update a rating for a given media item and confirm that the changes were updated in Firebase.  
DB3.4 Inputs: Update operation for media item   
DB3.5 Outputs: Updated data in the Firebase Realtime Database  
DB3.6 Normal  
DB3.7 Blackbox  
DB3.8 Functional  
DB3.9 Integration  

DB4.1 Firebase Database Test 4  
DB4.2 This test will ensure that delete operations from the mobile application will delete instantly from the Firebase Realtime Database.  
DB4.3 We will remove a media item from the Watched list and verify that the item is not present in Firebase.  
DB4.4 Inputs: Delete operation for media item in Watched list  
DB4.5 Outputs: The removal of the item from the Watched list in the Firebase Realtime Database  
DB4.6 Normal  
DB4.7 Blackbox  
DB4.8 Functional  
DB4.9 Integration  

SQ1.1 Search Query Test 1  
SQ1.2 This test will ensure that users can find media by media titles though string matching.  
SQ1.3 From the collection of media titles, we will choose a title to find. After entering this title, the results should be items that match the media title. If there are multiple matches, they should be sorted by release date.  
SQ1.4 Inputs: String media titles  
SQ1.5 Outputs: Media titles  
SQ1.6 Normal  
SQ1.7 Blackbox  
SQ1.8 Functional  
SQ1.9 Unit   

FA1.1 Firebase Authorization Test 1  
FA1.2 This test will ensure that logged-in users are able to access their data.  
FA1.3 We will ensure that the user can access their own data and not any other user data while logged in.  
FA1.4 Inputs: User credentials  
FA1.5 Outputs: User data  
FA1.6 Boundary  
FA1.7 Blackbox  
FA1.8 Functional  
FA1.9 Integration  

FA2.1 Firebase Authorization Test 2  
FA2.2 This test will ensure that logged-out users are unable to access any data.  
FA2.3 We will ensure that logged-out users cannot access the app without entering valid credentials.  
FA2.4 Inputs: Invalid credentials  
FA2.5 Outputs: No access  
FA2.6 Boundary  
FA2.7 Blackbox  
FA2.8 Functional  
FA2.9 Integration  

AN1.1 App Navigation Test 1  
AN1.2 This test will ensure that the user can correctly navigate the app with the bottom navigation menu from any screen.  
AN1.3 We will ensure that navigation links are accessible and correct for every screen of the application. The user should never get stuck on a screen with no way to navigate back.  
AN1.4 Inputs: Navigate through links to every screen of app  
AN1.5 Outputs: Expected navigation  
AN1.6 Normal  
AN1.7 Blackbox  
AN1.8 Functional  
AN1.9 Integration  

RW1.1 Rating Widget Test 1  
RW1.2 This test will ensure that the rating widget can be accessed through the search bar and recommendation section with a non-fixed screen position.  
RW1.3 We will place the widget in different positions on a fixed screen and a scrolling screen and check that the widget pop-up always appears in the center.  
RW1.4 Inputs: Varying vertical and horizontal placement of the widget button.  
RW1.5 Outputs: Rating widget pop-up always centered on screen.  
RW1.6 Normal  
RW1.7 Whitebox  
RW1.8 Performance  
RW1.9 Unit  

MR1.1 Media Recommendation Test 1  
MR1.2 This test will ensure that media recommendations are grouped by genres.  
MR1.3 We will input various media titles with different genre combinations and check that the top five resulting media titles have overlapping or similar genre combinations.  
MR1.4 Inputs: Media titles  
MR1.5 Outputs: Media titles  
MR1.6 Boundary  
MR1.7 Blackbox  
MR1.8 Performance  
MR1.9 Unit  

SR1.1 Subscription Recommendation Test 1  
SR1.2 This test will ensure that subscription recommendations for the "Watched" List are sorted by most occurrences.  
SR1.3 We will add multiple titles from three different subscription services to the "Watched" List. We will check that the subscription section recommends the same three services in order of the most frequently attributed services from the "Watched" List.  
SR1.4 Inputs: Media titles on the Watched List  
SR1.5 Outputs: Sorted subscription services  
SR1.6 Normal  
SR1.7 Blackbox  
SR1.8 Functional  
SR1.9 Integration  

SR2.1 Subscription Recommendation Test 2  
SR2.2 This test will ensure that subscription recommendations for the "To Watch" List are sorted by most occurrences.  
SR2.3 We will add multiple titles from three different subscription services to the To Watch List. We will check that the subscription section recommends the same three services in order of the most frequently attributed services from the "To Watch" List.  
SR2.4 Inputs: Media titles on the "To Watch" List  
SR2.5 Outputs: Sorted subscription services  
SR2.6 Normal  
SR2.7 Blackbox  
SR2.8 Functional  
SR2.9 Integration  

## Test Case Matrix

| | Normal/Abnormal/Boundary | Blackbox/Whitebox | Functional/Performance | Unit/Integration |
| :--- | :---: | :---: | :---: | :---: |
| DB1 | Normal | Whitebox | Functional | Integration |
| DB2 | Normal | Blackbox | Functional | Integration |
| DB3 | Normal | Blackbox | Functional | Integration |
| DB4 | Normal | Blackbox | Functional | Integration |
| SQ1 | Normal | Blackbox | Functional | Unit |
| FA1 | Boundary | Blackbox | Functional | Integration |
| FA2 | Boundary | Blackbox | Functional | Integration |
| AN1 | Normal | Blackbox | Functional | Integration |
| RW1 | Normal | Whitebox | Performance | Unit |
| MR1 | Boundary | Blackbox | Performance | Unit |
| SR1 | Normal | Blackbox | Functional | Integration |
| SR2 | Normal | Blackbox | Functional | Integration |

