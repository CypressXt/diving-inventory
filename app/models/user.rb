class User < ApplicationRecord
  attr_accessor :password_confirmation
  validates :name, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
  validates :name, :lastname, format: { without: /\@/ }
  validates :password, confirmation: true
  validates :password, :length => { minimum: 7 }
  validates :mail, uniqueness: true

  has_many :pressurelogs
end
