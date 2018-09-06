class AddInvitationTokenToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :invitation_token, :string
  end
end
