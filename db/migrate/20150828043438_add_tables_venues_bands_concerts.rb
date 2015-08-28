class AddTablesVenuesBandsConcerts < ActiveRecord::Migration
  def change
    create_table(:venues) do |t|
      t.column(:name, :string)
      t.column(:city, :string)
      t.column(:state, :string)
      t.timestamps(null: false)
    end
    create_table(:bands) do |t|
      t.column(:name, :string)
      t.timestamps(null: false)
    end
    create_table(:concerts) do |t|
      t.column(:band_id, :integer)
      t.column(:venue_id, :integer)
      t.column(:date, :timestamp)
      t.timestamps(null: false)
    end
  end
end
