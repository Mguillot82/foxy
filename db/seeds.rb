# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'
# Order of creation :
# User.new
# Taxonomy.new
# Badge.new
# Animal.new
# Collection.new
# Catch.new
# Collections_catch.new
# Got_badge.new
# Friendship.new

# Friendship.destroy_all
# Got_badge.destroy_all
# Collections_catch.destroy_all
# Catch.destroy_all
# Collection.destroy_all
# Animal.destroy_all
# Badge.destroy_all
# Taxonomy.destroy_all
# User.destroy_all

10.times do
  puts "Creating user..."
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(
    specifier: "#{first_name} #{last_name}",
    separators: ['-']
  )
  email = Faker::Internet.email(
    name: username,
    domain: 'foxy.fr'
  )
  password = "123456"
  user = User.new(
    {
      username:,
      email:,
      password:,
    }
  )
  user.save!
  puts "#{user.username} created !"
end

puts "____________________________"

TAXONOMY = ['Cat', 'Dog', 'Bird', 'Horse', 'Animal']
FAKER_CREATURE = [
  {
    species: 'Cat',
    name: 'breed'
  },
  {
    species: 'Dog',
    name: 'breed'
  },
  {
    species: 'Bird',
    name: 'common_family_name',
  },
  {
    species: 'Horse',
    name: 'breed'
  },
  {
    species: 'Animal',
    name: 'name'
  }
]

puts "Loading taxons..."
TAXONOMY.each do |name|
  taxon = Taxonomy.new(
    {
      name:
    }
  )
  puts "#{taxon} created !"
end

puts "____________________________"

puts "Creating animal..."

Taxonomy.all.each do |taxon|
  FAKER_CREATURE.each do |creature|
    animal = Animal.new(
      {
        taxonomy_id: taxon.id,
        name: Faker::Creature.const_get(taxon.name).send(creature.name) ,
        scientific_name: Faker::Military.space_force_rank,
        description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 3),
        location: Faker::Address.country
      }
    )
  end
end

puts "____________________________"

User.all.each do |user|
  puts "Creating catches for #{user.username} ..."
  Animal.all.each do |animal|
    puts "Creating catches for #{animal.name} ..."
    5.times do
      catch = Catch.new(
        user_id: user.id,
        animal_id: animal.id,
        location: Faker::Address.city
      )
    end
  end
end

puts "____________________________"
