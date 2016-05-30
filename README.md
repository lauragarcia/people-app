# PeopleApp

Web application to store contact information for people who want to share it. It lets you create, edit, delete your data whenever you want. Also, reports via email to all contacts when a new person has entered their data to the platform and when has been removed someone information.

## Specifications

* Ruby 2.2.2
* Rails 4.2.6
* Mysql
* Resque
* Minitest with FactoryGirl

Delivery date: 30 May 2016

## Instalation Process

Clone de repository

``$ git clone https://github.com/lauragarcia/people-app.git ``

Instal Gems

``$ bundle install``

Install Redis

``$ brew install redis``

and make sure that the server is running

``$ redis-server``

ImageMagick or GraphicsMagick command-line tool has to be installed. You can check if you have it installed by running:

``$ convert -version``

Open a new terminal tab and run the queue job process, this app has two queue :emails_new and :emails_deleted.

``$ VERBOSE=1 QUEUE=emails_new,emails_deleted rake environment resque:work ``

Migrate and seed the database

``$ rake db:create``
``$ rake db:migrate``
``$ rake db:seed``

To run tests
`` rake test ``
And finally, run rails server

``rails s``

Go to http://localhost:3000/ and that's all.