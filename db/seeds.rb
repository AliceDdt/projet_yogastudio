# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Administrator.create_with(password: "password")
             .find_or_create_by(email: "alice@projetprojet.com")
puts '-- Administrator created!'

Teacher.create_with(
  bio: "J'enseigne le yoga",
  first_name: "Yogi",
  last_name: "Ho",
  phone_number: "1234",
  address_attributes: {
    street: "1 rue de la paix",
    city: "Paris",
    zip_code: "75001",
  }
).find_or_create_by(email: "yogi@ho.com")
puts '-- Teacher created!'

User.create_with(
  first_name: "Jean",
  last_name: "Lassalle",
  phone_number: "6789",
  password: 'password',
  address_attributes: {
    street: "2 rue de la paix",
    city: "Paris",
    zip_code: "75001",
  }
).find_or_create_by(email: "client@yogastudio.fr")
puts '-- User created!'

COURSES_DATA = [
  {
  name: "Yoga Madras",
  short_description: "Un yoga doux et introspectif, le plus respectueux de chacun.e.",
  long_description: "Le Yoga de Madras, développé par Desikachar, insiste sur la prise de conscience du corps. La respiration sert de guide au mouvement et à la posture. Une attention toute particulière est donc portée au souffle. C’est le Yoga qui s’adapte et s’ajuste le plus à la personne. Tenant compte du parcours, des capacités et des besoins de chacun, cette pratique est un yoga doux et introspectif."
  },
  {
    name: "Yoga Vinyasa",
    short_description: "Le yoga le plus dynamique, souffle et mouvement en synchronisation.",
    long_description: "Il s'agit du yoga le plus dynamique dans lequel le souffle et le mouvement se synchronisent. Les postures s'enchaînent à un rythme précis sur lesquels vient se caler le souffle. À chaque mouvement correspond une respiration. La respiration vient  guider le mouvement, pour que celle-ci devienne le moteur. L’enchaînement de postures devient alors fluide, comme une chorégraphie."
  },
  {
    name: "Hatha Yoga",
    short_description: "Une pratique douce et tonifiante à l'écoute du souffle.",
    long_description: "Le haṭha yoga est une forme particulière de yoga qui vient de l'Inde sous l'impulsion du texte Haṭha Yoga Pradīpikā attribué au yogi Svatmarama et des Yoga Upanishad tardives, avant d'atteindre, au XXe siècle, l'Occident. Il signifie « yoga d'effort » et concerne principalement l'éveil spirituel par les postures correctes (āsana), la discipline du souffle (prāṇāyāma) et la méditation (dhyāna). Aujourd'hui, il constitue une pratique sous des formes diverses s'appuyant sur le travail corporel et l'attitude mentale correspondante."
  }
]

COURSES_DATA.each do |data|
  Course.create_with(
    short_description: data[:short_description],
    long_description: data[:long_description]
  ).find_or_create_by(name: data[:name])
end
puts '-- Courses created!'

Course.find_each do |course|
  next if course.yoga_sessions.any?

  course.yoga_sessions.create(
    start_date: Date.tomorrow.in_time_zone.at_noon,
    end_date: Date.tomorrow.in_time_zone.at_noon + 1.hour,
    price: 20,
    teacher: Teacher.first,
    number_participants: 5
  )
end
puts '-- YogeSessions created!'