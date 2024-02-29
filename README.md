# KANJI

Welcome to KANJI, where the treasures of the world are now within your reach. Imagine owning a piece of something rare, something with a story – from breathtaking art to historical artifacts. That's what we offer at KANJI. Our easy-to-use platform, powered by the latest technology, opens up the world of collectibles to everyone, not just the few. It's like having a share in a priceless treasure, making you a part of history itself. With KANJI, investing in these treasures is simple, safe, and accessible to all. Start your journey with us and make the extraordinary a part of your everyday life. Discover KANJI, where history meets opportunity.

## TEAM KANJI INFORMATION:

- **Product and Project Manager:** Irvin Moore
- **Tech Lead/Anchor:** Yoshihiro (Hiro) Yamada
- **Design Lead:** Jeremie Joseph

**Email:** [raritykanji@gmail.com](mailto:raritykanji@gmail.com)

**KANJI Wireframe:** [Kanji App Wireframe](https://sdlearn.slack.com/files/U0642RP2LR0/F06LYN47NJY/kanji_app_wireframe.pdf?origin_team=T04B40L2C&origin_channel=C06M36H9MUY)

**KANJI Database Schema:** [Kanji Database Schema](https://dbdiagram.io/d/Kanji-65dd028b5cd0412774dccd1b)

This KANJI application was built to completely build out a new curriculum shift and aid in the documentation process to implement JWT. Full CRUD was implemented and styling is reflective of Visable.ai wireframe created for students and updated with updated color and images.

## Deployment

Deployment was done through Render. Link can be found: [KANJI App](<Kanji App Link>)

## Setup Process

Documentation process followed: [Authenticate User with Devise Gem and Devise JWT in React Application by Villy Siu](<Documentation Link>)

1. Create Rails app: 
    ```bash
    $ rails new kanji-backend -d postgresql -T 
    $ cd kanji-backend
    ```
2. Add rack-cors, devise, devise-jwt, and dotenv-rails to gemfile:
    ```ruby
    gem 'rack-cors'
    gem 'devise'
    gem 'devise-jwt'
    gem 'dotenv-rails', groups: [:development, :test]
    ```
3. Run `$ bundle`

4. Setup CORS:
    - Add a file to the `config/initializers` directory named `cors.rb` and add the following code:
        ```ruby
        Rails.application.config.middleware.insert_before 0, Rack::Cors do
          allow do
            origins 'http://localhost:3001'
            resource '*',
            headers: ["Authorization"],
            expose: ["Authorization"],
            methods: [:get, :post, :put, :patch, :delete, :options, :head],
            max_age: 600
          end
        end
        ```

5. **Setup Devise:**
    - First, generate some devise files and folders:
        ```bash
        $ rails generate devise:install 
        $ rails generate devise User 
        $ rails db:migrate
        ```
    - Set up the default URL options for the Devise mailer in the development environment. Add the following code near the other mailer options in `config/environments/development.rb`:
        ```ruby
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
        ```
    - Ensure that Devise does not use flash messages since this is an API. Add the following to `config/initializers/devise.rb`:
        ```ruby
        config.navigational_formats = []
        ```

6. **Controllers and Routes:**
    - Access some additional files that Devise has available to handle sign-ups and logins:
        ```bash
        $ rails g devise:controllers users -c registrations sessions
        ```
    - Replace the code in the registrations controller and sessions controller:
        ```ruby
        # app/users/registrations_controller.rb
        class Users::RegistrationsController < Devise::RegistrationsController
          respond_to :json
          def create
            build_resource(sign_up_params)
            resource.save
            sign_in(resource_name, resource)
            render json: resource
          end
        end

        # app/users/sessions_controller.rb
        class Users::SessionsController < Devise::SessionsController
          respond_to :json
          private
          def respond_with(resource, _opts = {})
            render json: resource
          end
          def respond_to_on_destroy
            render json: { message: "Logged out." }
          end
        end
        ```
    - Update the devise routes in `config/routes.rb`:
        ```ruby
        Rails.application.routes.draw do
          get 'private/test'
          devise_for :users, 
            path: '', 
            path_names: {
              sign_in: 'login',
              sign_out: 'logout',
              registration: 'signup'
            },
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            }
        end
        ```

7. **Secret Key:**
    - Generate a secret key by running:
        ```bash
        $ bundle exec rails secret
        ```
    - Create a `.env` file in the root directory and add the key:
        ```bash
        # api/.env
        DEVISE_JWT_SECRET_KEY=<your_rails_secret>
        ```
    - Make sure to add `.env` to `.gitignore` as this should not be shared over git!

8. **Configure Devise-JWT:**
    - Add the following to `config/initializers/devise.rb`:
        ```ruby
        config.jwt do |jwt|
            jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
            jwt.dispatch_requests = [
              ['POST', %r{^/login$}],
            ]
            jwt.revocation_requests = [
              ['DELETE', %r{^/logout$}]
            ]
            jwt.expiration_time = 5.minutes.to_i
          end
        ```

9. **Revocation:**
    - Create a denylist table:
        ```bash
        $ rails generate model create_jwt_denylist
        ```
    - Update the migration file (`db/migrate/[date]_create_jwt_denylist.rb`):
        ```ruby
        def change
          create_table :jwt_denylist do |t|
            t.string :jti, null: false
            t.datetime :exp, null: false
          end
          add_index :jwt_denylist, :jti
        end
        ```
    - Migrate the database:
        ```bash
        $ rails db:migrate
        ```
    - Update the `JwtDenylist` model (`app/models/jwt_denylist.rb`):
        ```ruby
        class JwtDenylist < ApplicationRecord
          include Devise::JWT::RevocationStrategies::Denylist
          self.table_name = 'jwt_denylist'
        end
        ```
    - Update the user model so that it can use JWT tokens (`app/models/user.rb`):
        ```ruby
        class User < ApplicationRecord
          devise :database_authenticatable, :registerable,
                 :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
        end
        ```

10. Lastly, start the server and check that the backend is working properly:
    ```bash
    $ rails s
    ```
    Navigate to [http://localhost:3000/private/test](http://localhost:3000/private/test)




