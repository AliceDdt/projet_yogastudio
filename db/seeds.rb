# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Administrator.create(email: "alice@projetprojet.com", password: "password")

Teacher.create(
  bio: "J'enseigne le yoga",
  email: "yogi@ho.com",
  first_name: "Yogi",
  last_name: "Ho",
  phone_number: "1234",
  address_attributes: {
    street: "1 rue de la paix",
    city: "Paris",
    zip_code: "75001",
  }
)