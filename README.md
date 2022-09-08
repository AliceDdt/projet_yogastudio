# README

This project is for a fictional yoga studio 
and it allows you to book yogaclasses

Using Rails 7 and ruby-2.7.5

Back-office with gem Trestle Admin allows you to :
  - CRUD teachers
  - CRUD courses
  - create and delete yoga sessions
  - view users
  - view and delete bookings

Use of Stimulus JS for navbar, flash messages and form validation

Using Stripe gem for payment, you have to create your own account on https://stripe.com/fr
and put your stripe keys (publishable and secret) in your .env file

To install project: 
run bundle 
then rails db:create db:migrate db:seed

