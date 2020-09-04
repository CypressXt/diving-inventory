class User < ApplicationRecord
  attr_accessor :password_confirmation
  validates :name, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
  validates :name, :lastname, format: { without: /\@/ }
  validates :password, confirmation: true
  validates :password, :length => { minimum: 7 }
  validates :mail, uniqueness: true

  has_many :pressurelogs

  before_create :set_password
  before_save :set_lowercase

  def set_lowercase
    self.name = self.name.downcase
    self.lastname = self.lastname.downcase
    self.mail = self.mail.downcase
  end

  def encrypt_password(password)
    return Digest::SHA2.new(512).hexdigest(password+self.salt)
  end

  def authenticate(password)
    if encrypt_password(password) == self.password
      return true
    end
    return false
  end

  def set_password(password=self.password)
    passwd=self.encrypt_password(password)
    self.password = passwd
    self.password_confirmation = passwd
  end

  def gen_token_and_salt
    self.gen_token
    self.gen_salt
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(12)
      break token unless User.exists?(token: token)
    end
  end

  def gen_salt
    self.salt = loop do
      salt = SecureRandom.hex(12)
      break salt unless User.exists?(salt: salt)
    end
  end
end
