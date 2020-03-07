class AddCubageToPowerGenerator < ActiveRecord::Migration[5.2]
  def change
    add_column :power_generators, :cubage, :decimal,
               precision: 8, scale: 2, default: 0
  end
end
