class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :model_name
      t.string :brand_name
      t.integer :price
      t.string :year_of_manufacture

      t.timestamps
    end
  end
end
