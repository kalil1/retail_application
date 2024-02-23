# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Create active products
10.times do
  Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..10_000.0, as_string: false),
    status: 'active'
  )
end

# Create products in approval queue
5.times do
  product = Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 5_001..10_000.0, as_string: false),
    status: 'pending'
  )
  Approval.create(product: product, status: 'pending', request_date: Faker::Time.between(from: DateTime.now - 30, to: DateTime.now))
end

puts "Seed data generated successfully!"
