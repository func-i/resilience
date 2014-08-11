require 'rails_helper'
require Rails.root.join("spec/forms/search_forms_shared_context.rb")

describe Manage::UsersSearchForm do
  include_context 'base_search_methods'

  let(:search_params) { {search: {email_contains: 'email'}} }
  let(:searched_fields) { search.get_searches }
  let(:search) { Manage::UserSearch.new(email_contains: 'email')}

  subject { Manage::UsersSearchForm.new searched_fields,
    search_params
  }

  describe ".to_partial_path" do
    context "default partail path" do
      let(:default_partial_path) { 'manage/users/search_form' }

      it "returns default partial path" do
        expect( subject.to_partial_path).to eq(default_partial_path)
      end
    end

    context "custom partial path" do
      let(:custom_partial_path) { 'shared/manage/forms/users_search_form' }
      subject { Manage::UsersSearchForm.new searched_fields,
        search_params,
        custom_partial_path
      }

      it "returns default partial path" do
        expect( subject.to_partial_path).to eq(custom_partial_path)
      end
    end
  end

end
