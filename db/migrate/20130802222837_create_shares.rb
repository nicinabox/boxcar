class CreateShares < ActiveRecord::Migration
  def change
    create_table "shares" do |t|
      t.string   "name", :null => false
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
