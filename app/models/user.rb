require 'active_record'

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :memberships, :class_name => "Member", :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :stories

  attr_accessible :username, :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :username, :presence => true
  validates :email, :username, :uniqueness => true

end
