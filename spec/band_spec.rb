require 'spec_helper'

describe(Band) do
  it{should have_many(:venues)}
  it{should have_many(:concerts)}
end
