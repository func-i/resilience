module Manage
  class UserSearch < Searchlight::Search
    search_on User.includes(:roles)

    # define serach methods
    searches :email_contains,
      :name_contains,
      :organization_contatins,
      :has_role

    def search_email_contains
      search.where("users.email ILIKE :text", text: "%#{email_contains}%")
    end

    def search_name_contains
      search.where("users.name ILIKE :text", text: "%#{name_contains}%")
    end

    def search_organization_contatins
      search.where("users.organization ILIKE :text", text: "%#{organization_contatins}%")
    end

    def search_has_role
      search.where(roles: {id: has_role})
    end
  end
end
