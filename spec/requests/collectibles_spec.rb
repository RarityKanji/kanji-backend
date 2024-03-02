require 'rails_helper'

RSpec.describe "Collectibles", type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

  describe "GET /index" do
    it 'gets a list of collectibles' do
      collectible = user.collectibles.create(
        name: "Vintage Superman Comic",
        price: "570,000",
        image: "http://tinyurl.com/3zps2pnz",
        description: "A rare, mint condition Superman comic from 1938.",
        condition: "Mint",
        authenticity: "Certified",
        category: "Books", 
      )
      get '/collectibles'

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.first['name']).to eq("Vintage Superman Comic")
    end
  end

  describe "POST /create" do
    it "creates a collectible" do
      collectible_params = {
        collectible: {
          name: "Vintage Superman Comic",
          price: "570,000",
          image: "http://tinyurl.com/3zps2pnz",
          description: "A rare, mint condition Superman comic from 1938.",
          condition: "Mint",
          authenticity: "Certified",
          category: "Books", 
          user_id: user.id
        }
      }

      post '/collectibles', params: collectible_params
  
      expect(response).to have_http_status(200) 
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq("Vintage Superman Comic")
    end

    it 'returns a 422 status code for invalid data' do
      invalid_collectible_params = {
        collectible: {
          name: nil,
          price: nil,
          image: nil,
          description: nil,
          condition: nil,
          authenticity: nil,
          category: nil, 
          user_id: nil,
        }
      }

      post '/collectibles', params: invalid_collectible_params
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH /update" do
    let!(:collectible) do
      user.collectibles.create(
        name: "Vintage Superman Comic",
        price: "570,000",
        image: "http://tinyurl.com/3zps2pnz",
        description: "A rare, mint condition Superman comic from 1938.",
        condition: "Mint",
        authenticity: "Certified",
        category: "Books"
      )
    end
  
    it "updates a collectible" do
      updated_collectible_params = {
        collectible: {
          price: "575,000"
        }
      }
      
      patch "/collectibles/#{collectible.id}", params: updated_collectible_params
      
      expect(response).to have_http_status(200)
      collectible.reload
      expect(collectible.price).to eq("575,000")
    end

    it 'returns a 422 status code for invalid updates' do
      invalid_collectible_params = {
        collectible: {
          name: nil
        }
      }
      
      patch "/collectibles/#{collectible.id}", params: invalid_collectible_params
      
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a collectible' do
      collectible = user.collectibles.create(
        name: "First Edition of The Great Gatsby",
        price: "300,000",
        image: "http://tinyurl.com/22cpecht",
        description: "An original first edition of F. Scott Fitzgerald's The Great Gatsby.",
        condition: "Very Good",
        authenticity: "Certified",
        category: "Books", 
        user_id: user.id
      )

      delete "/collectibles/#{collectible.id}"

      expect(response).to have_http_status(:no_content) # Changed to no_content for successful deletion
      expect(Collectible.exists?(collectible.id)).to be false
    end
  end
end
