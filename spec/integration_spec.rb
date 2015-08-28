require('spec_helper')

describe('/bands', {type: :feature}) do
  it('loads index page') do
    visit('/')
    click_link('BANDS')
    expect(page).to have_content("BANDS")
    expect(page).to have_content("There are no bands. Turn up the volume by adding one.")
  end

  it('successfully adds a band') do
    visit('/bands')
    click_link('adding one')
    fill_in('name', with: "Foo Fighters")
    click_button('Add Band')
    expect(page).to have_content("Foo Fighters")
  end
end
