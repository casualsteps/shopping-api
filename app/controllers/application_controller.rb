class ApplicationController < ActionController::API
  before_action :authenticate!
  before_action :set_resource, only: %i[show update destroy]

  attr_accessor :current_advertiser, :current_publisher

  # GET /{plural_resource_name}/
  def index
    message = "ok"
    page = Integer(params[:page] || 1)
    page_size = Integer(params[:limit] || 25)
    page_size = 100 if page_size > 100

    begin
      resources = resource_class.where(query_params).page(page).per(page_size)
    rescue => e
      message = "Failed to get resources: #{e.message}"
    end

    render json: { model: resources, message: message }
  end

  # GET /{plural_resource_name}/:id
  def show
    render json: resource
  end

  # POST /api/{plural_resource_name}
  def create
    set_resource(resource_class.new(resource_params))

    if resource.save
      render json: { model: resource, message: "OK" }, status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /{plural_resource_name}/:id
  def update
    if resource.update(resource_params)
      render json: { model: resource, message: "OK" }
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /{plural_resource_name}/:id
  def destroy
    get_resource.destroy
    head :no_content
  end

  private

  def authenticate!
    api_key = request.headers["x-access-token"] || params[:api_key]

    if api_key.nil?
      self.current_advertiser = self.current_publisher = nil
    else
      self.current_advertiser = Trac::Advertiser.find_by(advertiser_api_key: api_key)
      logger.info "Advertiser [#{current_advertiser.name}] logged in." if current_advertiser

      self.current_publisher = current_advertiser.nil? ? Trac::Publisher.find_by(publisher_api_key: api_key) : nil
      logger.info "Publisher [#{current_publisher.name}] logged in." if current_publisher
    end

    render status: :unauthorized, json: { message: "Wrong API token!" } if current_advertiser.nil? && current_publisher.nil?
  end

  def advertiser_signed_in?
    !current_advertiser.nil?
  end

  def publisher_signed_in?
    !current_publisher.nil?
  end

  # Returns the resource from the created instance variable
  # @return [Object]
  def resource
    instance_variable_get("@#{resource_name}")
  end

  # Returns the allowed parameters for searching
  # Override this method in each API controller
  # to permit additional parameters to search on
  # @return [Hash]
  def query_params
    {}
  end

  # The resource class based on the controller
  # @return [Class]
  def resource_class
    @resource_class ||= "Trac::#{resource_name.classify}".constantize
  end

  # The singular name for the resource class based on the controller
  # @return [String]
  def resource_name
    @resource_name ||= self.controller_name.singularize
  end

  # Only allow a trusted parameter "white list" through.
  # If a single resource is loaded for #create or #update,
  # then the controller for the resource must implement
  # the method "#{resource_name}_params" to limit permitted
  # parameters for the individual model.
  def resource_params
    @resource_params ||= self.send("#{resource_name}_params")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource(resource_variable = nil)
    resource_variable ||= resource_class.find(params[:id])
    instance_variable_set("@#{resource_name}", resource_variable)
  end
end
