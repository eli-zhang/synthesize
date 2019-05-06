# synthesize
Synthesize: Collaborate on assignments with classmates remotely.

Synthesize is an app designed to provide Cornell students an easy way to collaborate on assignments and ask each other questions. The app fetches all the classes currently offered by Cornell and allows users to create an assignment for that class. Users can then join a group chat and anonymously message each other with questions about that specific assignment. Synthesize was designed to help solve the problem many students have - they're enrolled in classes and don't know other students in that class, so they have nobody to work with. Students like to work collaboratively and often learn better that way, and Synthesize creates a platform for this.

Requirements:
iOS: 
	- AutoLayout: Each screen meets this by using NSLayoutConstraint.
	- Collection View or Table View: The home screen features two collection views, the browse screen has a table view, each class screen has a table view, and each message screen has a collection view.
	- Navigation: The app uses a UITabBarController and a UINavigationController.
	- Integration with an API: The app fetches classes, assignments, and messages from the API written by the backend team.

Screenshots:
![home](https://github.com/eli-zhang/synthesize/blob/master/readmeimages/home.jpg)
![browse](https://github.com/eli-zhang/synthesize/blob/master/readmeimages/browse.jpg)
![class](https://github.com/eli-zhang/synthesize/blob/master/readmeimages/class.jpg)
![message](https://github.com/eli-zhang/synthesize/blob/master/readmeimages/message.jpg)
