# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(
  projects.scss 
  static_pages.scss 
  users.scss 
  groups.scss 
  courses.scss 
  sessions.scss
  password_reset.scss
  account_activations.scss
  )
Rails.application.config.assets.precompile += %w(
  projects.js 
  groups.js 
  users.js 
  sessions.js
  static_pages.js
  account_activation.coffee
  password_reset.coffee
  )

Rails.application.config.assets.precompile += %w(
  projects/edit.js
  courses/new.js
)
