require 'active_record'

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :username, :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :username, :presence => true
  validates :email, :username, :uniqueness => true

end
