require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  erb(:index)
end

get("/bands") do
  @bands = Band.order("name").all
  erb(:bands)
end

get("/bands/new") do
  erb(:add_band)
end

get('/bands/:id') do
  id = params['id'].to_i
  @band = Band.find(id)
  erb(:band_info)
end

post("/bands") do
  name = params['name']
  @band = Band.new({name: name})
  if @band.save
    redirect("/bands/#{@band.id}")
  else
    erb(:add_band)
  end
end

get("/bands/:id/edit") do
  @band = Band.find(params['id'].to_i)
  erb(:edit_band)
end

patch("/bands/:id") do
  @band = Band.find(params['id'].to_i)
  name = params['name']
  if @band.update({name: name})
    redirect("/bands/#{@band.id}")
  else
    erb(:edit_band)
  end
end

delete("/bands/:id") do
  band = Band.find(params['id'].to_i)
  band.destroy
  redirect("/bands")
end

get("/venues") do
  @venues = Venue.order("state", "city", "name").all
  erb(:venues)
end

get("/venues/new") do
  erb(:add_venue)
end

get('/venues/:id') do
  id = params['id'].to_i
  @venue = Venue.find(id)
  erb(:venue_info)
end

post("/venues") do
  name = params['name']
  city = params['city']
  state = params['state']
  @venue = Venue.new({name: name, city: city, state: state})
  if @venue.save
    redirect("/venues/#{@venue.id}")
  else
    erb(:add_venue)
  end
end

get("/venues/:id/edit") do
  @venue = Venue.find(params['id'].to_i)
  erb(:edit_venue)
end

patch("/venues/:id") do
  @venue = Venue.find(params['id'].to_i)
  name = params['name']
  city = params['city']
  state = params['state']
  if @venue.update({name: name, city: city, state: state})
    redirect("/venues/#{@venue.id}")
  else
    erb(:edit_venue)
  end
end

delete("/venues/:id") do
  venue = Venue.find(params['id'].to_i)
  venue.destroy
  redirect("/venues")
end
