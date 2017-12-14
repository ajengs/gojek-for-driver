require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is valid with a email, first name, last name, phone, password, license' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a first_name' do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last_name' do
    user = build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without a phone' do
    user = build(:user, phone: nil)
    user.valid?
    expect(user.errors[:phone]).to include("can't be blank")
  end

  it 'is invalid without a license' do
    user = build(:user, license_plate: nil)
    user.valid?
    expect(user.errors[:license_plate]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    user1 = create(:user, email: 'user@gmail.com')
    user = build(:user, email: 'user@gmail.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it 'is invalid with a duplicate phone' do
    user1 = create(:user, phone: '1234567890')
    user = build(:user, phone: '1234567890')
    user.valid?
    expect(user.errors[:phone]).to include("has already been taken")
  end

  it 'is invalid with a duplicate license' do
    user1 = create(:user, license_plate: '1234567890')
    user = build(:user, license_plate: '1234567890')
    user.valid?
    expect(user.errors[:license_plate]).to include("has already been taken")
  end

  it 'is invalid with an email other than given format' do
    user = build(:user, email: 'harry@gryffindorcom')
    user.valid?
    expect(user.errors[:email]).to include('format is invalid')
  end

  it 'is invalid with phone number not numeric' do
    user = build(:user, phone: '09-4748')
    user.valid?
    expect(user.errors[:phone]).to include('is not a number')
  end

  it 'is invalid with phone number length > 12' do
    user = build(:user, phone: '0998975757893')
    user.valid?
    expect(user.errors[:phone]).to include('is too long (maximum is 12 characters)')
  end

  context 'on a new user' do
    it 'is invalid without a password' do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is invalid with less than 8 characters password' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it 'is invalid with a confirmation mismatch' do
      user = build(:user, password: 'longpassword', password_confirmation: 'longpasssssssss')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context 'on an existing user' do
    before :each do
      @user = create(:user)
    end

    it 'is valid with no changes' do
      expect(@user.valid?).to eq(true)
    end

    it 'is invalid with an empty password' do
      @user.password_digest = ''
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'is valid with a new valid password' do
      @user.password = 'newlongpassword'
      @user.password_confirmation = 'newlongpassword'
      expect(@user.valid?).to eq(true)
    end
  end

  it 'can set current location' do
    user = create(:user)
    user.current_location = "65678 878899"
    user.save
    expect(user.current_location).to eq("65678 878899")
  end
  
  describe "relations" do
    # it { should have_many(:orders) }
  #   it 'should have many orders' do
  #     user = create(:user)
  #     order1 = create(:order, user: user)
  #     order2 = create(:order, user: user)
  #     expect(user.orders).to match_array([order1, order2])
  #   end
  end

  context 'setting location' do
    before :each do
      @user = create(:user, current_location: "Grand Indonesia")
    end

    it 'can set current location with valid address' do
      @user.set_location("Kolla Space Sabang")
      expect(@user.current_location).to eq("Kolla Space Sabang")
    end

    it 'does not change current location with invalid address' do
      @user.set_location("xsxsd")
      expect(@user.current_location).to eq("Grand Indonesia")
    end
  end
end
