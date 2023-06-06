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
CollectionsCatch.destroy_all
Catch.destroy_all
Collection.destroy_all
Animal.destroy_all
Badge.destroy_all
Taxonomy.destroy_all
User.destroy_all

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
      password:
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
    name: 'common_family_name'
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

BADGES = [
    ["first", "bronze", "silver", "gold"],
    ["You have caught one of its kind",
      "You have caught five of its kind",
      "You have caught ten of its kind",
      "You have caught twenty of its kind"],
    [1,5,10,20],
    ['Cat', 'Dog', 'Bird', 'Horse', 'Animal']
]

puts "Loading taxons..."
TAXONOMY.each do |name|
  taxon = Taxonomy.new(
    {
      name:
    }
  )
  taxon.save!
  puts "#{taxon} created !"
end

puts "____________________________"

puts "Creating animal..."
FAKER_CREATURE.each do |creature|
  taxon = Taxonomy.find_by(name: creature[:species])
  animal = Animal.new(
    {
      taxonomy_id: taxon.id,
      name: Faker::Creature.const_get(creature[:species]).send(creature[:name]),
      scientific_name: Faker::Military.space_force_rank,
      description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 3),
      location: Faker::Address.country
    }
  )
  if animal.save
    puts "#{animal} created !"
  end
end

puts "____________________________"

puts "Creating catches"
User.all.each do |user|
  puts "Creating catches for #{user.username} ..."
  Animal.all.each do |animal|
    5.times do
      catch = Catch.new(
        {
          user_id: user.id,
          animal_id: animal.id,
          location: Faker::Address.city
        }
      )
      catch.save!
      puts "#{catch} created !"
    end
  end
end


puts "____________________________"

puts "Creating collection..."
User.all.each do |user|
  collection = Collection.new(
    {
      user_id: user.id,
      name: Faker::Ancient.primordial,
      description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 3)
    }
  )
  collection.save!
  puts "#{collection.name} created for #{user.username}"
end

puts "____________________________"

puts "Creating collections_catches..."

Collection.all.each do |collection|
  Catch.all.each do |catch|
    next if catch.user_id == collection.user_id

    collection_catch = CollectionsCatch.new(
      catch_id: catch.user_id,
      collection_id: collection.user_id
    )
    puts "collection catch #{collection_catch.catch_id} added in  #{collection.name}"
  end
end

index = 0
BADGES[3].each do |category|
  BADGES[0].each do |name|
    badge = Badge.new(
      {
        name: "#{category} #{name}",
        description: BADGES[1][index],
        condition: BADGES[2][index],
        category:
      }
    )
    index += 1
    puts "Badges created #{badge.name}"
  end
end
