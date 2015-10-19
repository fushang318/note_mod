module NoteMod
  class ApplicationController < ActionController::Base
    layout "note_mod/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
      include PlayAuth::SessionsHelper
    end
  end
end