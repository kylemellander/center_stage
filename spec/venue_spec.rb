require 'spec_helper'

describe(Venue) do
  it{should have_many(:bands)}
  it{should have_many(:concerts)}
end
