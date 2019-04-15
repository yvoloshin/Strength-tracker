class CreateWeightUnits < ActiveRecord::Migration
  def change
    create_table :weight_units do |t|
    	t.string :name
    	t.decimal :conversion_factor_to_lb, precision: 10, scale: 4 
    end
  end
end
