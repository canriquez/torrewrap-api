class Search < ApplicationRecord
  belongs_to :user

  validates_presence_of :search_key, :search_url

end
