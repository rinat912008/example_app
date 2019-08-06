require 'rails_helper'

describe Posts::Create do
  subject { described_class.call(user, message: message) }

  let(:user) { create(:user) }
  let(:message) { 'some message' }

  shared_examples 'post invalid' do |messages|
    it 'returns Post#count' do
      expect { subject }.not_to change { Post.count }.from(0)
    end

    it 'returns errors' do
      expect(subject.errors.full_messages).to eq(messages)
    end
  end

  context 'without user' do
    let(:user) {}

    it_behaves_like 'post invalid', ['please specify user', "User must exist"]
  end

  context 'with user' do
    context 'without message' do
      let(:message) {}

      it_behaves_like 'post invalid', ["Message can't be blank"]
    end

    context 'with message' do
      it 'returns Post#count' do
        expect { subject }.to change { Post.count }.from(0).to(1)
      end

      it 'returns errors' do
        expect(subject.errors.full_messages).to be_empty
      end
    end
  end
end
