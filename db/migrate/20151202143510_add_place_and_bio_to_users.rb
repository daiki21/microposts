class AddPlaceAndBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :place, :string
    add_column :users, :bio, :string
  end
end
