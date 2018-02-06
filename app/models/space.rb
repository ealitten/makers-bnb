class Space

  include DataMapper::Resource

  property :id, Serial
  property :title, String
  # required: true, unique: true
  property :description, String
  # , required: true
  property :price, Integer
  # , required: true

end
