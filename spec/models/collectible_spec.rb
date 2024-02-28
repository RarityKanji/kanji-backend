require 'rails_helper'

RSpec.describe Collectible, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  it 'should validate name' do
    collectible = user.collectibles.create(
      price: "570,000",
      image: "http://tinyurl.com/3zps2pnz",
      description: "A rare, mint condition Superman comic from 1938.",
      condition: "Mint",
      authenticity: "Certified",
    )
    expect(collectible.errors[:name]).to include("can't be blank")
  end

  it 'should validate price' do
    collectible = user.collectibles.create(
      name: "Vintage Superman Comic",
      image: "http://tinyurl.com/3zps2pnz",
      description: "A rare, mint condition Superman comic from 1938.",
      condition: "Mint",
      authenticity: "Certified",
    )
    expect(collectible.errors[:price]).to include("can't be blank")
  end

  it 'should validate image' do
    collectible = user.collectibles.create(
      name: "Vintage Superman Comic",
      price: "570,000",
      description: "A rare, mint condition Superman comic from 1938.",
      condition: "Mint",
      authenticity: "Certified",
    )
    expect(collectible.errors[:image]).to include("can't be blank")
  end

  it 'should validate description' do
    collectible = user.collectibles.create(
      name: "Vintage Superman Comic",
      price: "570,000",
      image: "http://tinyurl.com/3zps2pnz",
      condition: "Mint",
      authenticity: "Certified",
    )
    expect(collectible.errors[:description]).to include("can't be blank")
  end

  it 'should validate condition' do
    collectible = user.collectibles.create(
      name: "Vintage Superman Comic",
      price: "570,000",
      image: "http://tinyurl.com/3zps2pnz",
      description: "A rare, mint condition Superman comic from 1938.",
      authenticity: "Certified",
    )
    expect(collectible.errors[:condition]).to include("can't be blank")
  end

  it 'should validate authenticity' do
    collectible = user.collectibles.create(
      name: "Vintage Superman Comic",
      price: "570,000",
      image: "http://tinyurl.com/3zps2pnz",
      description: "A rare, mint condition Superman comic from 1938.",
      condition: "Mint",
    )
    expect(collectible.errors[:authenticity]).to include("can't be blank")
  end
end