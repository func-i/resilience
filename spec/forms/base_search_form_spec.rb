require 'rails_helper'
require Rails.root.join("spec/forms/search_forms_shared_context.rb")

describe BaseSearchForm do
  include_context 'base_search_methods'

  let(:search_params) { {search: {name_contains: 'cli'}} }
  let(:searched_fields) { search.get_searches }
  let(:search) { Manage::UserSearch.new(name_contains: 'Client Name')}

  subject {
    BaseSearchForm.new(searched_fields,
      search_params
    )
  }

  describe '.to_partial_path' do
    it "raise a error" do
      expect{subject.to_partial_path}.to raise_error NotImplementedError
    end
  end

end
