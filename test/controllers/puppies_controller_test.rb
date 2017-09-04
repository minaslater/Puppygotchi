require "test_helper"

class PuppyControllerTest < ActionDispatch::IntegrationTest
  # puppies#new
  test "/puppies/new is a valid route" do
    get "/puppies/new"
    assert_response :success
  end

  # tests puppies#create
  test "post to /puppies makes a new Puppy" do
    login_test_user(users(:test_user))
    number_of_puppies = users(:test_user).puppies.count
    post "/puppies", params: { puppy: { name: "Lulu" } }

    assert_equal(number_of_puppies + 1, users(:test_user).puppies.count, "puppy record not found")
  end

  test "should add notice to flash after success" do
    login_test_user(users(:test_user))
    post "/puppies", params: { puppy: { name: "Nemo" } }
    assert_equal "Congrats!", flash[:notice]
  end

  test "should redirect to puppy page after success" do
    login_test_user(users(:test_user))
    post "/puppies", params: { puppy: { name: "Dory" } }
    assert_redirected_to controller: "puppies", action: "show", id: users(:test_user).puppies.last.id
  end

  test "should not create puppy without logging in" do
    before_count = Puppy.all.count
    post "/puppies", params: { puppy: { name: "Bungee" } }
    assert_equal before_count, Puppy.all.count
  end

  test "should add alert if attempt without logging in" do
    post "/puppies", params: { puppy: { name: "Bungee" } }
    assert_equal "Please log in", flash[:alert]
  end

  test "should redirect to root on attempt with no login" do
    post "/puppies", params: { puppy: { namd: "Bungee" } }
    assert_redirected_to root_path
  end

  test "should not create puppy with invalid params" do
    login_test_user(users(:test_user))
    before_count = users(:test_user).puppies.count
    post "/puppies", params: { puppy: { name: "" } }
    assert_equal before_count, users(:test_user).puppies.count
  end

  test "should add alert on failure" do
    login_test_user(users(:test_user))
    post "/puppies", params: { puppy: { name: "" } }
    assert_equal "Name can't be blank", flash[:alert]
  end

  test "should redirect to new on failure" do
    login_test_user(users(:test_user))
    post "/puppies", params: { puppy: { name: "" } }
    assert_redirected_to controller: "puppies", action: "new"
  end

  # tests puppies#update
end
