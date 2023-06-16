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

BADGES = [
  {
    name: 'First Bird',
    photo: 'development/t03d5lswslyv5jw3ilk44hav5or1',
    condition: 1,
    description: 'You have caught one of its kind',
    category: 'Aves'
  },
  {
    name: '5 Birds',
    photo: 'development/i154f7te4i7ftfo5vgotnkoil40q',
    condition: 5,
    description: 'You have caught five of its kind',
    category: 'Aves'
  },
  {
    name: '10 Birds',
    photo: 'development/5grzr7ksfw34l3ljk5f3mpgh8x5v',
    condition: 10,
    description: 'You have caught ten of its kind',
    category: 'Aves'
  },
  {
    name: '20 Birds',
    photo: 'development/vu4n0vfxa8n3ye8hzfukxm15wk9e',
    condition: 20,
    description: 'You have caught twenty of its kind',
    category: 'Aves'
  },
  {
    name: 'First Mammalia',
    photo: 'development/xibn2jxqn4gp6exqx1epvwa5y0xd',
    condition: 1,
    description: 'You have caught one mammalia',
    category: 'Mammalia'
  },
  {
    name: '5 Mammalias',
    photo: 'development/2erdzodbhy1wg3cd9d6eteh39a1t',
    condition: 5,
    description: 'You have caught five mammalias',
    category: 'Mammalia'
  },
  {
    name: '10 Mammalias',
    photo: 'development/7rdzcnbts6i69xos0494yij7krjf',
    condition: 10,
    description: 'You have caught ten mammalias',
    category: 'Mammalia'
  },
  {
    name: '20 Mammalias',
    photo: 'development/0ehqwfwiwslw40u9byfwc473o6pr',
    condition: 20,
    description: 'You have caught twenty mammalias',
    category: 'Mammalia'
  }
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
