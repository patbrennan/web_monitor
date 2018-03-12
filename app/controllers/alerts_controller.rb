class AlertsController < ApplicationController
  before_action :require_user # require a user first
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_alert, only: [:show, :edit]
  before_action :require_shared_user, only: [:edit, :update, :destroy, :crawls, :show]
  
  def index; end
  
  def show # /users/:user_id/alerts/:id
    
  end
  
  def new # GET /users/:user_id/alerts/new
    @user = current_user
    @alert = Alert.new
  end
  
  def create # POST /users/:user_id/alerts/new
    @alert = Alert.new(alert_params)
    @user = current_user
    
    if @alert.save
      @alert.users << @user #TODO: refactor so user can select sharing w/users
      flash[:success] = "Alert created."
      redirect_to user_alerts_path(@user)
    else
      flash[:error] = "Alert not created"
      render :new
    end
  end
  
  def edit # GET /users/:user_id/alerts/:id/edit
    @alert = Alert.find(params[:id])
  end
  
  def update # PUT /users/:user_id/alerts/:id/edit
    if @alert.update(alert_params)
      flash[:success] = "Alert updated."
      redirect_to user_alerts_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    
  end
  
  def crawls
    @alert = Alert.find(params[:alert_id])
    @crawls = @alert.crawls
    
    respond_to do |f|
      f.html
      f.json { render json: @crawls }
    end
  end
  
  private
  
  def alert_params
    params.require(:alert).permit(:name, :url, :crawl_interval_mins, :notify_emails, :active, :response_time_threshold_ms)
  end
  
  def set_alert
    @alert = Alert.find(params[:id])
  end
  
  def set_user
    @user = User.find_by(username: params[:user_id])
  end
  
  # User must be in the join table user_alerts (shared) to have access
  def require_shared_user
    set_alert
    access_denied unless @alert.users.include? current_user
  end
end