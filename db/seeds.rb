# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'
require "open-uri"
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

nb_user = 10
nb_animal = 3
nb_badges = 3
nb_friends = 5

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
  # ["first", "bronze", "silver", "gold"],
  # [
  #  "You have caught one of its kind",
  #   "You have caught five of its kind",
  #   "You have caught ten of its kind",
  #   "You have caught twenty of its kind"
  # ],
  # [1, 5, 10, 20],
  # ['Horse', 'Cat', 'Dog', 'Bird', 'Fox', 'Animal'],
  # [

  {
    name: 'Animal First',
    photo: nil,
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Animal'
  },
  {
    name: 'Animal Bronze',
    photo: nil,
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Animal'
  },
  {
    name: 'Animal Silver',
    photo: nil,
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Animal'
  },
  {
    name: 'Animal Gold',
    photo: nil,
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Animal'
  },
  {
    name: 'Horse First',
    photo: nil,
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Horse'
  },
  {
    name: 'Horse Bronze',
    photo: nil,
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Horse'
  },
  {
    name: 'Horse Silver',
    photo: nil,
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Horse'
  },
  {
    name: 'Horse Gold',
    photo: nil,
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Horse'
  },
  {
    name: 'Cat First',
    photo: 'development/jjyshghfz6livfsz1kzek5mm6ll4',
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Cat'
  },
  {
    name: 'Cat Bronze',
    photo: 'development/dgsoat8t14tfairguufnxlp9zokq',
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Cat'
  },
  {
    name: 'Cat Silver',
    photo: 'development/3yijx7ycdcbmsmeo1urw5gpufw0g',
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Cat'
  },
  {
    name: 'Cat Gold',
    photo: 'development/pz3c6bhi1tufapcb9c5bwpnljafu',
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Cat'
  },
  {
    name: 'Dog First',
    photo: 'development/kht4j9wmgahyw41p3j060s3skts1',
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Dog'
  },
  {
    name: 'Dog Bronze',
    photo: 'development/xkcohxnuttlgez0lslqang8mqy7p',
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Dog'
  },
  {
    name: 'Dog Silver',
    photo: 'development/v9clxr2yiohvq9diygaq21m9evkq',
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Dog'
  },
  {
    name: 'Dog Gold',
    photo: 'development/s3qk4glwc59qqbattekbp5vyek9i',
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Dog'
  },
  {
    name: 'Bird First',
    photo: 'development/t03d5lswslyv5jw3ilk44hav5or1',
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Aves'
  },
  {
    name: 'Bird Bronze',
    photo: 'development/i154f7te4i7ftfo5vgotnkoil40q',
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Aves'
  },
  {
    name: 'Bird Silver',
    photo: 'development/5grzr7ksfw34l3ljk5f3mpgh8x5v',
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Aves'
  },
  {
    name: 'Bird Gold',
    photo: 'development/vu4n0vfxa8n3ye8hzfukxm15wk9e',
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Aves'
  },
  {
    name: 'Fox First',
    photo: 'development/xibn2jxqn4gp6exqx1epvwa5y0xd',
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Fox'
  },
  {
    name: 'Fox Bronze',
    photo: 'development/2erdzodbhy1wg3cd9d6eteh39a1t',
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Fox'
  },
  {
    name: 'Fox Silver',
    photo: 'development/7rdzcnbts6i69xos0494yij7krjf',
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Fox'
  },
  {
    name: 'Fox Gold',
    photo: 'development/0ehqwfwiwslw40u9byfwc473o6pr',
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Fox'
  }
]

FRIENDSHIPS = [
  "pending",
  "accepted",
  "rejected"
]

Friendship.destroy_all
puts "friendship destroyed"
GotBadge.destroy_all
puts "GotBadge destroyed"
CollectionsCatch.destroy_all
puts "CollectionsCatch destroyed"
Catch.destroy_all
puts "Catch destroyed"
Collection.destroy_all
puts "Collection destroyed"
Animal.destroy_all
puts "Animal destroyed"
Badge.destroy_all
puts "Badge destroyed"
Taxonomy.destroy_all
puts "Taxonomy destroyed"
User.destroy_all
puts "User destroyed"

nb_user.times do
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

puts "Loading taxons..."
TAXONOMY.each do |name|
  taxon = Taxonomy.new(
    {
      name:
    }
  )
  taxon.save!
  puts "#{taxon.name} created !"
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
    puts "#{animal.name} created !"
  end
end

puts "____________________________"

puts "Creating catches"
User.all.each do |user|
  puts "Creating catches for #{user.username} ..."
  Animal.all.each do |animal|
    nb_animal.times do
      catch = Catch.new(
        {
          user_id: user.id,
          animal_id: animal.id,
          latitude: Faker::Address.latitude,
          longitude: Faker::Address.longitude
        }
      )
      catch.save!
      puts "#{catch.latitude} created !"
      puts "#{catch.longitude} created !"
      puts "#{catch.location} created !"
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

Catch.all.each do |catch|
  Collection.all.each do |collection|
    next if catch.user_id != collection.user_id

    collection_catch = CollectionsCatch.new(
      catch_id: catch.id,
      collection_id: collection.id
    )
    collection_catch.save!
    puts "collection catch #{collection_catch.catch_id} added in  #{collection.id}"
  end
end

# Upload badge photo
# development/
# absolute_path = "/Users/nidhogg/code/Mguillot82/foxy/db/badges/"
# # upload badge photo on cloudinary
# file = URI.open("#{absolute_path}#{category}-#{name.capitalize}.png")
# sleep(1)
# puts "image uploaded"
# badge.photo.attach(
#   io: file,
#   filename: "#{category}-#{name.capitalize}",
#   content_type: "image/png"
# )

BADGES.each do |tmp|
  badge = Badge.new(
    {
      name: tmp[:name],
      condition: tmp[:condition],
      description: tmp[:description],
      category: tmp[:category]
    }
  )

  if tmp[:photo]
    url_photo = Cloudinary::Api.resource(tmp[:photo])['url']
    sleep(1)
    p url_photo
    file = URI.open(url_photo)
    badge.photo.attach(io: file, filename: tmp[:name])
  end
  badge.save!
  puts "Badges created #{badge}"
end

puts "____________________________"

puts "Creating Got Badges..."

User.all.each do |user|
  nb_badges.times do
    badge_id = Badge.first.id.to_i + rand(19)
    got_badges = GotBadge.new(
      {
        badge_id:,
        user_id: user.id
      }
    )
    got_badges.save!
  end
  puts "Got Badges for user #{user.username} created"
end

puts "____________________________"

puts "Creating collections_catches..."
