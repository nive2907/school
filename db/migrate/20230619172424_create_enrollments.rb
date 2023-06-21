class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.integer :school_id
      t.integer :user_id
      t.integer :batch_id
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
