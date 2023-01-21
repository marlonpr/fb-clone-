class ProfilesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @profile = Profile.find(params[:id])
  end
  
  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to @profile, notice: "Profile was successfully created."
    else
      render :new
    end
  end
  
  private
  
  def profile_params
    params.require(:profile).permit(:name, :bio, :location, :avatar)
  end
  
end
