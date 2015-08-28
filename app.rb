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
  band = Band.find(params['id'].to_i)
  name = params['name']
  band.update({name: name})
  redirect("/bands/#{band.id}")
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
