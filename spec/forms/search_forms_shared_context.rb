require 'rails_helper'

shared_context 'base_search_methods' do
  describe '.new' do
    describe 'instance variables ' do
      it {
        expect(
          subject.instance_variable_get(:@field_values)
        ).to eq(search_params)
      }
    end

    describe '.dynamic accessors' do
      it 'responds to searched fields' do
        searched_fields.each do |field|
          expect(subject.respond_to?(field)).to eq(true)
        end
      end
    end
  end

  describe 'class instance methdods' do
    it ".persisted?" do
      expect(subject.persisted?).to eq(false)
    end

    it ".to_key" do
      expect(subject.to_key).to eq([])
    end
  end
end
