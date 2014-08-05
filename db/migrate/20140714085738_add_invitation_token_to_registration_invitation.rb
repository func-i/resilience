class AddInvitationTokenToRegistrationInvitation < ActiveRecord::Migration
  def change
    add_column :registration_invitations, :invitation_token, :string
    add_index :registration_invitations, :invitation_token
  end
end
