require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create :user }
  subject { Item.new }
  describe 'validations' do
    it 'must have an associated user' do
      subject.valid?
      expect(subject.errors.full_messages).to include("User must exist")
    end

    it 'must have a manufacturer' do
      subject.valid?
      expect(subject.errors.full_messages).to include("Manufacturer can't be blank")
    end

    it 'must have a model' do
      subject.valid?
      expect(subject.errors.full_messages).to include("Model can't be blank")
    end

    it 'must have a price' do
      subject.valid?
      expect(subject.errors.full_messages).to include("Price can't be blank")
    end

    # it 'must have an image' do
    #   subject.valid?
    #   expect(subject.errors.full_messages).to include("no file added")
    # end

    it 'can not contain special characters in the manufacturer' do
      subject.manufacturer = "%%manufacturer$"
      subject.valid?
      expect(subject.errors.full_messages).to include("Manufacturer no special characters allowed")
    end

    it 'can not contain special characters in the serial number' do
      subject.serial_number = "%serial_number$"
      subject.valid?
      expect(subject.errors.full_messages).to include("Serial number no special characters allowed")
    end

    it 'can not contain special characters in the model' do
      subject.model = "%model$"
      subject.valid?
      expect(subject.errors.full_messages).to include("Model no special characters allowed")
    end

    it 'can not contain special characters in the color' do
      subject.color = "%color$"
      subject.valid?
      expect(subject.errors.full_messages).to include("Color no special characters allowed")
    end

    it 'is invalid if price is over 100,000' do
      subject.price = 100_001
      subject.valid?
      expect(subject.errors.full_messages).to include("Price must be less than 100000")
    end

    it 'is invalid if weight is over 10,000' do
      subject.weight = 10_001
      subject.valid?
      expect(subject.errors.full_messages).to include("Weight must be less than 10000")
    end

    it 'is invalid if description is over 160 characters' do
      subject.description =
        <<~HEREDOC
          maybe this is over 160 characters long, but who
          knows thats a lot of characters to fill up an
          entire space. guess i didn't quite make it,
          hopefully this will help me reach my character goal
        HEREDOC

      subject.valid?
      expect(subject.errors.full_messages).to include("Description is too long (maximum is 160 characters)")
    end

    it 'is invalid if description is too short' do
      subject.valid?
      expect(subject.errors.full_messages).to include("Description is too short (minimum is 1 character)")
    end

    it 'is invalid if model is over 20 characters' do
      subject.model = "this is probably about twenty letters long"
      subject.valid?
      expect(subject.errors.full_messages).to include("Model is too long (maximum is 20 characters)")
    end

    it 'is invalid if model is too short' do
      subject.valid?
      expect(subject.errors.full_messages).to include("Model is too short (minimum is 1 character)")
    end

    it 'validates a valid item' do
      item = build(:item)
      expect(item.valid?).to eq(true)
    end
  end
end
