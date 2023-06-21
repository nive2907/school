class CreateBatches < ActiveRecord::Migration[6.0]
  def change
    create_table :batches do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :school_id
      t.timestamps
    end
  end
end
