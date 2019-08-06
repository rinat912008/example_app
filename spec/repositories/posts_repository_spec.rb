require 'rails_helper'

describe PostsRepository do
  subject { described_class.new.latest_posts }

  shared_examples 'post found' do
    it 'returns Post#count' do
      expect(subject.size).to eq(1)
    end

    it 'returns post id' do
      expect(subject.first.id).to eq(post.id)
    end
  end

  shared_examples 'post not found' do
    it 'returns Post#count' do
      expect(subject.size).to be_zero
    end
  end

  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, published: published) }

  context 'when post not published' do
    let(:published) { false }

    it_behaves_like 'post not found'
  end

  context 'when post published' do
    let(:published) { true }

    it_behaves_like 'post found'
  end
end
