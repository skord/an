class AddExtraAndCredentialsToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :extra, :text
    add_column :authentications, :credentials, :text
  end
end
