require 'rails_helper'

describe Post, type: :model do
  context '#validations' do
    subject { create(:post) }

    it { is_expected.to validate_presence_of(:user).with_message(:required) }
    it { is_expected.to validate_presence_of(:message) }
  end
end
