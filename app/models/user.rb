class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :trackable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body

  extend FriendlyId
  friendly_id :username, use: :slugged

  attr_accessor :uuid

  has_many :memberships, :class_name => "Member", :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :stories

  validates :username, :presence => true
  validates :username, :uniqueness => true

end
