class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :asset_type
      t.string :cloud_url

      t.timestamps
    end
  end
end
