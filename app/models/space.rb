class Space

  include DataMapper::Resource

  property :id, Serial
  property :title, String
  # required: true
  property :description, String
  # , required: true
  property :price, Integer
  # , required: true
  belongs_to :user

end
