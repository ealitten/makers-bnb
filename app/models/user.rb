require 'bcrypt'

class User

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :username, String, required: true, unique: true
  property :email, String, required: true, format: :email_address, unique: true
  property :encrypted_password, Text

  has n, :spaces

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    self.encrypted_password = Password.create(new_password)
  end

end
