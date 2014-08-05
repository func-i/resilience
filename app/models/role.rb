class Role < ActiveRecord::Base
  ALLOWED_ROLES = %w(administrator  regular)
  DEFAULT_ROLE = 'regular'

  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true

  scopify
end