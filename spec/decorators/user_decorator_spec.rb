require 'spec_helper'

describe UserDecorator do

  let(:first_name)  { 'John'  }
  let(:last_name)  { 'Smith' }

  let(:user) { create(:user, 
                     first_name: first_name, 
                     last_name: last_name) }

  let(:decorator) { user.decorate }

  describe '.fullname' do
    context 'with a first and last name' do
      it 'should return the full name' do
        expect(decorator.full_name).to eq("John Smith")
      end
    end

    context 'without a first or last name' do
      before do
        user.first_name = ''
        user.last_name = ''
      end

      it 'should return no name provided' do
        expect(decorator.full_name).to eq('No name provided.')
      end
    end
  end

  describe '.joined_at' do
    it 'should return created month name and year' do
      expect(decorator.joined_at).to eq(user.created_at.strftime("%B %Y"))
    end
  end
end

