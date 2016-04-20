class ApplicationController < ActionController::Base
  if defined? PlayAuth
    helper PlayAuth::SessionsHelper
    include PlayAuth::SessionsHelper
  end
end
