require('spec_helper')

describe("/bands", {type: :feature}) do
  it('loads index page') do
    visit('/')
    click_link('BANDS')
    expect(page).to have_content("BANDS")
    expect(page).to have_content("There are no bands. Turn up the volume by adding one.")
  end

  it('successfully adds a band and corrects case') do
    visit('/')
    click_link('Add Band')
    fill_in("name", with: "foo fighters")
    click_button('ADD BAND')
    expect(page).to have_content("Foo Fighters")
  end
end

describe("/venues", {type: :feature}) do
  it('displays all venues') do
    visit('/')
    click_link("VENUES")
    expect(page).to have_content("VENUES")
    expect(page).to have_content("There are no venues. Turn up the volume by adding one.")
  end

  it('successfully adds a venue and corrects case') do
    visit('/')
    click_link('Add Venue')
    fill_in("name", with: "madison square GaRDENS")
    fill_in("city", with: "New YOrk")
    select('NY', from: 'state')
    click_button('ADD VENUE')
    expect(page).to have_content("Madison Square Gardens")
    expect(page).to have_content("New York, NY")
  end
end
