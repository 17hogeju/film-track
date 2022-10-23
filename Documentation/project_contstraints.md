# Project Design Constraints

## Diversity and Cultural:

There are cultural constraints that will impact our application - because there are time and cost constraints on our project as a whole/how we get our media data, our application will be targeted towards North America. As of now we plan to support English as the only language for our app, as well as prioritizing the population of our database with the most popular media from North America.
Ultimately, promoting diversity in our application will not just increase the number of potential users for our app but also the user experience. With more users and media outside of North America, our application could recommend more media/subscriptions that users may not have considered - for example, our users may discover that they immensely enjoy bollywood/anime because they share other favorited media with users outside of North America.

## Economic Constraints:

Our project has a few economic constraints. As students we cannot afford to spend money on building a highly scalable backend with low latency, so we have to use services with minimal to no cost upfront, especially for development purposes. This also places a restriction on how many concurrent users we can have. In addition, we will need to work with free APIs to gather information about media for our solution. Some of those free APIs have rate limitations that we will have to consider while designing our solution. Our project has an ML component as well and deploying those ML models on a personal device that feeds into the interface for our users would impact user experience due to high latency, so we need to host our custom ML models on the cloud, however, we cannot put any advanced services such as model drift monitoring around it, as those, would be quite expensive.

## Ethical Constraints:


