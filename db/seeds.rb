# Clear out existing data in development to start fresh
if Rails.env.development?
  puts "Resetting development database..."
  User.destroy_all
  Collectible.destroy_all
end

# Create Users
puts "Creating users..."
users = [
  { email: "collector@example.com", password: "password", password_confirmation: "password" },
  { email: "trader@example.com", password: "password", password_confirmation: "password" },
  { email: "investor@example.com", password: "password", password_confirmation: "password" }
]
# user = User.where(email: "test@example.com").first_or_create(password: "password", password_confirmation: "password")
users.each do |user_attributes|
  User.create!(user_attributes)
end

# Mock Collectibles
puts "Creating collectibles..."
collectible_attributes = [
  {
    name: "Vintage Superman Comic",
    price: "570,000",
    image: "http://tinyurl.com/3zps2pnz",
    description: "A rare, mint condition Superman comic from 1938.",
    condition: "Mint",
    authenticity: "Certified",
    category: "Books",
  },
  {
    name: "First Edition of The Great Gatsby",
    price: "300,000",
    image: "http://tinyurl.com/22cpecht",
    description: "An original first edition of F. Scott Fitzgerald's The Great Gatsby.",
    condition: "Very Good",
    authenticity: "Certified",
    category: "Books",
  },
  {
    name: "Signed Copy of To Kill a Mockingbird",
    price: "200,000",
    image: "http://tinyurl.com/2p9vuazt",
    description: "A rare signed edition of Harper Lee's To Kill a Mockingbird.",
    condition: "Mint",
    authenticity: "Certified",
    category: "Books",
  },
  {
    name: "Original Charizard Pokémon Card",
    price: "250,000",
    image: "http://tinyurl.com/5fbue8nk",
    description: "Highly coveted Charizard Pokémon card in near-perfect condition.",
    condition: "Near Mint",
    authenticity: "Certified",
    category: "Cards",
  },
  {
    name: "Black Lotus - Alpha Edition",
    price: "500,000",
    image: "http://tinyurl.com/zf23zrfw",
    description: "The Alpha edition Black Lotus, renowned for its rarity and power in the game of Magic: The Gathering.",
    condition: "Near Mint",
    authenticity: "Certified",
    category: "Cards",
  },
  {
    name: "Pikachu Illustrator Card",
    price: "900,000",
    image: "http://tinyurl.com/47h38taa",
    description: "One of the rarest Pokémon cards ever made, awarded to winners of the 1998 CoroCoro Comic Illustration Contest.",
    condition: "Mint",
    authenticity: "Certified",
    category: "Cards",
  },
  {
    name: "18th Century Sapphire Gem",
    price: "825,000",
    image: "http://tinyurl.com/4supnc5y",
    description: "A stunning sapphire gem from the 18th century, with verified authenticity.",
    condition: "Good",
    authenticity: "Verified",
    category: "Gems",
  },
  {
    name: "Rare Ruby - The Sunrise Ruby",
    price: "1,200,000",
    image: "http://tinyurl.com/2az2csux",
    description: "The Sunrise Ruby, a rare and stunning gem known for its deep red color.",
    condition: "Excellent",
    authenticity: "Verified",
    category: "Gems",
  },
  {
    name: "Exceptional Emerald - The Mogul Mughal",
    price: "2,500,000",
    image: "http://tinyurl.com/56a5648u",
    description: "The Mogul Mughal Emerald, one of the largest emeralds with historical significance.",
    condition: "Good",
    authenticity: "Verified",
    category: "Gems",
  },
]

users = User.all
collectible_attributes.each do |attributes|
  user = users.sample
  user.collectibles.create!(attributes)
end

puts "Seeding completed. Created #{User.count} users and #{Collectible.count} collectibles."