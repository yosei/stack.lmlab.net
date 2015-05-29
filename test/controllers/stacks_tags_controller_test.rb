require 'test_helper'

class StacksTagsControllerTest < ActionController::TestCase
  setup do
    @stacks_tag = stacks_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stacks_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stacks_tag" do
    assert_difference('StacksTag.count') do
      post :create, stacks_tag: { name: @stacks_tag.name, stack_id: @stacks_tag.stack_id }
    end

    assert_redirected_to stacks_tag_path(assigns(:stacks_tag))
  end

  test "should show stacks_tag" do
    get :show, id: @stacks_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stacks_tag
    assert_response :success
  end

  test "should update stacks_tag" do
    patch :update, id: @stacks_tag, stacks_tag: { name: @stacks_tag.name, stack_id: @stacks_tag.stack_id }
    assert_redirected_to stacks_tag_path(assigns(:stacks_tag))
  end

  test "should destroy stacks_tag" do
    assert_difference('StacksTag.count', -1) do
      delete :destroy, id: @stacks_tag
    end

    assert_redirected_to stacks_tags_path
  end
end
