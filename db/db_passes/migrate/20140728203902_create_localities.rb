class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.belongs_to :pass
      t.references :localitiable, :polymorphic => true

      t.timestamps
    end
    add_index :localities, [:localitiable_id, :localitiable_type]
  end
end
