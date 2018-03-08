class AlertsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  
  def index
    
  end
  
  def show
    
  end
  
  def new
    @user = current_user
    @alert = Alert.new
  end
  
  def create
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
  
  def edit
    
  end
  
  def udpate
    
  end
  
  def destroy
    
  end
  
  private
  
  def alert_params
    params.require(:alert).permit(:name, :url, :crawl_interval_mins, :notify_emails, :active, :response_time_threshold_ms)
  end
  
  def set_alert
    
  end
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
end