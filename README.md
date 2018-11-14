# Coin Collection Application

This is a coin collecting application in Ruby on Rails 3.2. 

See a video walkthrough here: http://www.mbondpro.com/2018/11/coin-collection-tracking-application.html

To set up, don't forget to perform the following actions:

For Capistrano deployment, configure deploy.rb with your info.
Configure config/database.yml with your DB info.
Set the secret key within config/initializers/secret_token.rb
Set config/environments/
Put your email address in the 'admin email' helper method in application_helper.rb
Put your email signature in app/views/clearance_mailer/signature.html.erb
Update the AuctionResult model with your eBay affiliate and developer IDs
Update views, as desired, with customized text.

You can partially populate the database after running migrations by running the SQL files in the db folder.
