require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:searchs)}
  it { should validate_presence_of (:public_id)}  
  it { should validate_presence_of (:picture_thumbnail)}  
  it { should validate_presence_of (:password_digest)}  

end
