class UsersController < ApplicationController
  skip_before_action :require_login, only:[:login_user, :new, :create, :create_borrower, :login]
  def new
  end

  def login_user
    @user = Lender.find_by(email: params[:email].downcase)
    @borrower =Borrower.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      session[:id]=@user.id
        redirect_to "/lender/#{session[:id]}"
    elsif @borrower && @borrower.authenticate(params[:password])
        session[:id]=@borrower.id
        redirect_to "/borrower/#{session[:id]}"
    else
      flash[:error] = "Invalid Combination"
      redirect_to '/login'
    end
  end

  def borrower
    @borrower=Borrower.find(session[:id])
    @lender=@borrower.lenders.uniq
    @history=@borrower.histories.uniq
  end

  def lender
    @lender=Lender.find(session[:id])
    @borrowers=Borrower.all
    @Lborrowers=@lender.borrowers.uniq
  end

  def edit
  
  end

  def create
    @user = Lender.new user_params 
    if @user.save
      session[:lender_id]=@user.id
      redirect_to "/login"
    else
      flash[:errors] = @user.errors.full_messages
    redirect_to '/register'
    end
  end

  def create_borrower
    @user = Borrower.new user_params 
    if @user.save
      session[:lender_id]=@user.id
      redirect_to "/login"
    else
      flash[:errors] = @user.errors.full_messages
    redirect_to '/register'
    end
  end

  def login
    
  end
  def lend
    @lender=Lender.find(session[:id])
    if params[:money]<@lender.money
      @hist=History.new(amount:params[:money], lender:Lender.find(session[:id]), borrower: Borrower.find(params[:id]))
      @hist.save
      @lender.money=@lender.money.to_i-params[:money].to_i
      @lender.save
      @borrower=Borrower.find(params[:id])
      @borrower.raised=@borrower.raised.to_i+params[:money].to_i
      @borrower.save
      redirect_to "/lender/#{session[:id]}"
    else 
      flash[:errors] = "Error: Invalid Lending"
      redirect_to "/lender/#{session[:id]}"
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update user_params
      redirect_to "/users/#{@user.id}/edit"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def logout
    reset_session
    redirect_to "/login"
  end

  def destroy
    @user=User.find(params[:id]).destroy
    reset_session
    redirect_to "/"
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :status, :password, :money, :title, :description,:raised, :password_confirmation)
  end

end
