# require "test_helper"
# 
# class PuppyControllerTest < ActionDispatch::IntegrationTest
#   test "/ is a valid route" do
#     get "/"
#     assert_response :success
#   end
# 
#   test "/puppies/new is a valid route" do
#     get "/puppies/new"
#     assert_response :success
#   end
# 
#   test "post to /puppies makes a new Puppy" do
#     number_of_puppies = Puppy.all.count
#     post "/puppies", params: { puppy: { name: "Lulu" } }
# 
#     assert_equal(number_of_puppies + 1, Puppy.all.count, "puppy record not found")
#   end
# end
