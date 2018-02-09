class Request
  include DataMapper::Resource

  property :id, Serial
  property :date, Date
  property :approved, Boolean

  belongs_to :user
  belongs_to :space

end
