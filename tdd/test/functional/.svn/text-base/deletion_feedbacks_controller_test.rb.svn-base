require File.expand_path('../../test_helper.rb', __FILE__)

class DeletionFeedbacksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @deletion_feedback = deletion_feedbacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deletion_feedbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deletion_feedback" do
    assert_difference('DeletionFeedback.count') do
      post :create, :deletion_feedback => @deletion_feedback.attributes
    end

    assert_redirected_to deletion_feedback_path(assigns(:deletion_feedback))
  end

  test "should show deletion_feedback" do
    get :show, :id => @deletion_feedback.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @deletion_feedback.to_param
    assert_response :success
  end

  test "should update deletion_feedback" do
    put :update, :id => @deletion_feedback.to_param, :deletion_feedback => @deletion_feedback.attributes
    assert_redirected_to deletion_feedback_path(assigns(:deletion_feedback))
  end

  test "should destroy deletion_feedback" do
    assert_difference('DeletionFeedback.count', -1) do
      delete :destroy, :id => @deletion_feedback.to_param
    end

    assert_redirected_to deletion_feedbacks_path
  end
end
