require 'rails_helper'

RSpec.describe Attachment, :type => :model do
  context "associations" do
    it "belongs to polymorphic assocaition" do
      is_expected.to belong_to(:attachable)
    end
  end

  context "validations" do
    it " validate presence of file_name" do
      is_expected.to validate_presence_of :file
    end
  end

  describe "#file" do
    let(:file) { File.open "#{Rails.root}/spec/fixtures/files/user_photo.jpg" }
    subject { Attachment.new }

    it "store the file" do
      expect {
        subject.file = file
        subject.save
      }.to change {
        subject.file
      }
    end
  end
end
