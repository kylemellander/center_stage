require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  erb(:index)
end

get("/bands") do
  @bands = Band.all
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
