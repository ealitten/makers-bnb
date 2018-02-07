class Hire
  include DataMapper::Resource

  property :id, Serial
  property :date, Date

  belongs_to :user
  belongs_to :space
end
