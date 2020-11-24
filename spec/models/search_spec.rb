require 'rails_helper'

RSpec.describe Search, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :search_key}  
  it { should validate_presence_of :search_url}  
end
