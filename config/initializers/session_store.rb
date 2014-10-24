# Be sure to restart your server when you modify this file.

if Rails.env.production?
  Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 6.hours
else
  Slideonline::Application.config.session_store :cookie_store, key: '_slideonline_session'
end
