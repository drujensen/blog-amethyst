require "./spec_helper"

describe LoginController do
  
  describe "#new" do
     it "should show the login form" do
      controller = create_controller_instance(LoginController)
      controller.call_action "new"
      controller.response.body.should contain "Sign In"
    end
  end
  
  describe "#create" do
    it "should authorize the user" do
      controller = create_controller_instance(LoginController, "POST",
                                              "/session/create?username=admin&password=xxx")
      controller.call_action "create"
      expect_raises(KeyError) do
        controller.session[:authorized].should eq "true"
      end
    end
  end
  
  describe "#delete" do
     it "should destroy the session" do
      controller = create_controller_instance(LoginController)
      controller.call_action "delete"
      expect_raises(KeyError) do
        controller.session[:authorized]
      end
    end
  end
end
