class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/vnd.radd.v1' }
  attr_accessor :resource_class, :resource_params, :custom_url
  respond_to :json
  before_action :set_headers

  rescue_from StandardError do |e|
    render json: {success: false, errors: 'Oopss, Something went wrong  ===>  '+ e.message}, status: 500
  end
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'Etag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, If-Modified-Since, If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end

  def index
    @resources = self.resource_class.all
    render :json => { success: true, data: @resources }, status: 200
  end

  def create
    @resource = self.resource_class.new self.resource_params
    unless @resource.save
      render :json => { success: false, errors:  @resource.errors.full_messages.uniq }, status: 404
    else
      render :json => { success: true, data: @resource, message: "#{self.resource_class} Created Successfully" }, status: 200
    end
  end

  def show
  end

  def edit
  end

  def update
    if @resource.update_attributes self.resource_params
      render :json => { success: true, message: "#{self.resource_class} updated Successfully" }, status: 200
    else
      render :json => { success: false, errors:  @resource.errors.full_messages.uniq }, status: 401
    end
  end

  def destroy
    if @resource.destroy
      render :json => { success: true }, status: 200
    else
      render :json => { success: false, errors:  @resource.errors.full_messages.uniq }, status: 401
    end
  end

  protected

  def set_resource_class_attributes(klass)
    self.resource_class = klass
  end

  def set_resource_params_attributes(resource_params={})
    self.resource_params = resource_params
  end

  def set_resource
    @resource = self.resource_class.find(params[:id])
  end

end