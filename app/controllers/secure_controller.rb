class SecureController < ApplicationController
  before_filter :authenticate_user!
end
