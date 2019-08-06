require 'rails_helper'

describe Like, type: :model do
  context '#validations' do
    subject { create(:like) }

    it { is_expected.to validate_presence_of(:user).with_message(:required) }
    it { is_expected.to validate_presence_of(:post).with_message(:required) }
    it do
      expect(subject)
        .to validate_uniqueness_of(:user_id)
        .scoped_to(:post_id)
        .with_message('user can like the post only once')
    end
  end
end
