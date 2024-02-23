class CreateApprovals < ActiveRecord::Migration[7.1]
  def change
    create_table :approvals do |t|
      t.integer :product_id
      t.string :status
      t.datetime :request_date

      t.timestamps
    end
  end
end
