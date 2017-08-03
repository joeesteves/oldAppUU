require 'rails_helper'

RSpec.describe Ba::Relacion, type: :model do
  it { should belong_to(:empresa) }
  it { should belong_to(:organizacion) }
  it { should validate_presence_of(:tipo)}
end
