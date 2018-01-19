require 'rails_helper'

RSpec.describe Device, type: :model do
  it "belongs to user through created_by field" do
    should belong_to(:created_by)
  end

  it "validates presence of name" do
    should validate_presence_of(:name)
  end

  it "validates presence of MAC" do
    should validate_presence_of(:MAC)
  end

end
