class Space

  include DataMapper::Resource

  property :id, Serial
  property :title, String, required: true
  property :description, String, required: true
  property :price, Integer, required: true
  property :availability_start, Date
  property :availability_end, Date

  belongs_to :user
  has n, :hires

end
