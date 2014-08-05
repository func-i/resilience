class CreateRegistrationInvitations < ActiveRecord::Migration
  def change
    create_table :registration_invitations do |t|
      t.references :sender
      t.string :recipient_email
      t.references :recipient
      t.string :state

      t.timestamps
    end
  end
end
