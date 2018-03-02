MakersBnB challenge
==================

Maker's Academy group project to create a clone of a popular website which lets you list and book spaces to stay in.


Technologies used
-------

- Ruby
- Sinatra web framework
- PostgresSQL database
- Bcrypt gem (for encrypting user passwords)
- Heroku


Requirements 
-------

#### Running locally for development:

+ PostgreSQL installed
+ A local postgres database named 'makersbnb_development'

All gem requirements can be installed by installing the bundler gem (`gem install bundle`) and then running `bundle install` in the project directory.

#### Using the deployed app on heroku: 

+ None


Instructions
-------

#### Running locally for development:

- Launch the site: run `rackup` in the project root folder
- Navigate to  http://localhost:9292 in your browser

#### Using the deployed app on heroku: 

+ Visit the webpage: https://tranquil-fjord-66043.herokuapp.com

#### Once the app is launched:

+ You'll see a sign up page where you can create an account (or click 'Sign in' if you already have one)
+ Once you're signed in, there are three main options:
  + Spaces: A list of spaces to hire. You can request to hire one for a particular date from this page.
  + List a space: Put a space of your own up for hiring
  + Requests: View requests to hire your space, and requests you've made for others' spaces. You can approve or disapprove requests for your spaces on this page.


## User Stories implemented

```
As a user
So that I can list a space
I would like to sign up

As a user
So that someone can hire my space
I would like to list a space

As a user
So that I can provide information for the space
I would like to provide a name, description and price for the space.

As a user
So that someone can hire a space
I would like to show the dates my space is available

As a signed-up user
So I can hire a space
I would like to request to hire a space for one night

```

## Spec (all features implemented)

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.


## Todo / possible extensions

- Styling and layout
- Better navigation (create nav bar with links to different pages)
- Interstitial request page, where user can add text to their request, rather than requesting straight from /spaces
- Allow users to add an image of their space
