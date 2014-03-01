class TestController < ApplicationController
  def index
  end

  def module
    render layout: false
  end

  def another_module
    render layout: false
  end
end