class Hire

  include DataMapper::Resource

  property :id, Serial
  property :date, String

  belongs_to :user
  belongs_to :space
end

