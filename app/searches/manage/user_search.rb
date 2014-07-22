module Manage
  class UserSearch < Searchlight::Search
    search_on User.includes(:roles)

    # define serach methods
    searches :email_contains,
      :name_contains,
      :organization_contains,
      :has_role

    def search_email_contains
      search.where("users.email ILIKE :text", text: "%#{email_contains}%")
    end

    def search_name_contains
      search.where("users.name ILIKE :text", text: "%#{name_contains}%")
    end

    def search_organization_contains
      search.where("users.organization ILIKE :text", text: "%#{organization_contains}%")
    end

    def search_has_role
      search.where(roles: {id: has_role})
    end

    # expose search methods
    def get_searches
      self.public_methods.map(&:to_s).select { |m|
        m.start_with?('search_') }.map { |m| m.sub(/\Asearch_/, '').to_sym
      }
    end
  end
end
