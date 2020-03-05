class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  protect_from_forgery with: :null_session
end
