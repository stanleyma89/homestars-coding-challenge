### Installation and running this solution

1. `bundle install`
2. `rails db:create`
3. `rails db:seed`
4. `rails s`
5. To run tests `rails test`


### Few words on which features were selected and why?

1. As a consumer of the API, I can persist my chat messages
2. As a consumer of the API, I can persist messages in specific channels I join.
3. As a consumer of the API, I can see the list of all the available channels
4. As a consumer of the API, I can look up other users and channels

I chose these features because they are they are the minimum required to have a working chat application.

### Possible next steps if you had more time. What assumptions did you make?

Assumptions
1. User cannot persist message in a channel they haven't joined
2. User cannot join a channel they have already joined
3. User and Channel has a many to many relationship

Next Steps
1. Paginate responses
2. Adding proper error messages
