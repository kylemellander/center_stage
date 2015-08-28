require("bundler/setup")
require 'pry'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://opytzercvudnjr:uzOB_XVK5PzebDiwmhHJ5gwqR8@ec2-54-83-59-154.compute-1.amazonaws.com:5432/deanc1oq6c1975')

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
  @upcoming_concerts = Concert.where(band_id: id).where("date >= ?", Time.now-1.day).order('date ASC').all
  @past_concerts = Concert.where(band_id: id).where("date <= ?", Time.now-1.day).order('date DESC').all
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

post("/bands/:id/concerts/new") do
  if params['concerts'] != nil
    @band = Band.find(params['id'].to_i)
    @venues = []
    params['concerts'].each do |id|
      @venues.push(Venue.find(id.to_i))
    end
    erb(:add_concert_through_band)
  else
    redirect("/bands/#{params['id'].to_i}")
  end
end

post("/bands/:id/concerts") do
  venues = params['venues']
  months = params['months']
  days = params['days']
  years = params['years']
  band_id = params['id'].to_i
  i=0
  venues.each do |venue_id|
    date = Time.new(years[i],months[i],days[i])
    Concert.create({venue_id: venue_id.to_i, band_id: band_id, date: date})
    i+=1
  end
  redirect("/bands/#{band_id}")
end
