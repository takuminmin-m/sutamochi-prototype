class SampleController < ApplicationController
  def index
    render json: { 'message': 'this is index' }
  end

  def create
    render json: { 'message': 'this is create' }
  end

  def update
    render json: { 'message': 'this is update' }
  end

  def delete
    render json: { 'message': 'this is delete' }
  end
end
