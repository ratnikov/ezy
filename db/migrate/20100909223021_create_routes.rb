class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.datetime :arrive_at

      t.belongs_to :user

      t.belongs_to :to, :from

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
