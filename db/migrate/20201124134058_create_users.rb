class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :public_id
      t.string :password_digest
      t.string :picture_thumbnail
      t.string :video_url
      t.string :json_response

      t.timestamps
    end
  end
end
