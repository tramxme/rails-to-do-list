require 'spec_helper'

describe Item do
  it {should validate_presence_of(:description)}
  it {should ensure_length_of(:description).is_at_least(10)}
  it {should ensure_length of(:description).is_less_than(50)}
end
