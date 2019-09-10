class OmniauthCallbackController < ApplicationController

  def twitter
    callback_form :twitter
  end
end