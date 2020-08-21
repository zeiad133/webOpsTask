# frozen_string_literal: true

class User < ApplicationRecord
  # enum role: %i[employee coordinator admin]
  # after_initialize :set_default_role, if: :new_record?


  include ImageUploader::Attachment.new(:image)
  has_many :comments, dependent: :delete_all
  has_many :posts, dependent: :delete_all

  # validates :name, :image , :email , presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp

  # validates :body, :title, length: { in: 1..255, allow_nil: false }


  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
  
 

  

  

  def self.from_token_payload payload
    self.find payload["sub"]
  end

  def authenticate(password)
    self.valid_password?(password)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
