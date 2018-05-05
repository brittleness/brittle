defmodule SystemMock do
  def user_home! do
    System.user_home!()
    "/Users/alice"
  end
end
