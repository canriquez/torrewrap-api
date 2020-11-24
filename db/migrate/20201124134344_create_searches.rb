class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :search_key
      t.string :search_url

      t.timestamps
    end
  end
end
