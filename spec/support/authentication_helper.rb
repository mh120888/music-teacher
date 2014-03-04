module AuthenticationHelper

	def valid_signin(user, password)
		visit login_path
		fill_in "Email", with: user.email
		fill_in "Password", with: password
		click_button "Log In"
	end

	def stub_login user
	  ApplicationController.any_instance.stubs(:current_user).returns(user)
	end
end