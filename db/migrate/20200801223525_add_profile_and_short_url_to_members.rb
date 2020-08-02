class AddProfileAndShortUrlToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :profile, :text, array: true, default: []
    add_column :members, :short_url, :string
  end
end
