class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  helper_method :current_user
  helper_method :current_database
  helper_method :class_name

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    instance_variable_set("@#{class_name.downcase}".to_sym, class_name.constantize.new)
    respond_to do |format|
      format.html { render "layouts/new_edit" }
    end
  end

  # GET /passes/1/edit
  def edit
    respond_to do |format|
      format.html { render "layouts/new_edit" }
    end
  end

  def create
    instance_variable_set("@#{class_name.downcase}".to_sym, class_name.constantize.new(self.send("#{class_name.downcase}_params")))

    respond_to do |format|
      if get_item.save
        format.html { redirect_to get_item, notice: '#{class_name} was successfully created.' }
        format.json { render json: get_item, status: :created, location: get_item }
      else
        format.html { render "layouts/new_edit" }
        format.json { render json: get_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /passes/1
  # PUT /passes/1.json
  def update
    respond_to do |format|
      if get_item.update(self.send("#{class_name.downcase}_params"))
        format.html { redirect_to get_item, notice: '#{class_name} was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "layouts/new_edit" }
        format.json { render json: get_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    belongs_to_associations = class_name.constantize.reflect_on_all_associations(:belongs_to)
    if belongs_to_associations.blank?
      return_item = self.send("#{class_name.pluralize.downcase}_path")
    else
      return_item = get_item.send(belongs_to_associations.first.klass.name.downcase)
    end
    get_item.destroy
    
    respond_to do |format|
      format.html { redirect_to return_item }
      format.json { head :no_content }
    end
  end

  private 

  def set_item
    instance_variable_set("@#{class_name.downcase}".to_sym, class_name.constantize.find(params[:id]))
  end

  def get_item
    instance_variable_get("@#{class_name.downcase}")
  end

  def class_name
    controller_name.classify
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def record_not_found
    if controller_name.classify.downcase == "bike"
      @error_msg = model_translated + " non trovata!"
    else
      @error_msg = model_translated + " non trovato!"
    end
   
    redirect_to brands_path, :flash => { :error => _(@error_msg) }
    true
  end

  def current_database
    return "passes" if ["Pass","Locality"].include? controller_name.classify
    return "bikes" if ["Brand","Model","Bike"].include? controller_name.classify
    return "municipalities"
  end
  
end
