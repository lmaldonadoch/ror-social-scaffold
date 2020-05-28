require 'rails_helper'

RSpec.feature 'Sign', type: :feature do
  describe '#log_in' do
    let(:user) { User.create(name: 'test', email: 'tes@test.com', password: '123456', password_confirmation: '123456') }
    scenario 'The root page is the timeline' do
      visit 'http://localhost:3000/users/sign_in'

      p user

      within find('#new_user') do
        fill_in 'user_email', with: 'tes@test.com'
        fill_in 'user_password', with: '123456'
        click_button 'commit'
      end
      expect(current_path).to eq('/')
    end
  end
end
