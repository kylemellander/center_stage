require 'spec_helper'

describe(Concert) do
  it{should belong_to(:band)}
  it{should belong_to(:venue)}
end
