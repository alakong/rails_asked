class UsersController < ApplicationController

  def posts
    @user=User.find(params[:id])
    @posts=@user.posts
  end

  def index
  end

  def new
  end

  def create
    unless User.find_by(email: params[:email])
      @user=User.create(username: params[:username],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])

      if @user.save
        #가입되면 true return
        flash[:notice]="welcome!"
        redirect_to "/"

        #비밀번호가 달라서 저장이 안되면 false return
      else
        flash[:alert]="check you password again"
        redirect_to :back

      end
    else
      flash[:alert]="email is already registered"
      redirect_to :back

    end


    # #1. email 중복 검증 .find_by(email: 값)
    # if User.find_by(email: params[:email])
    #
    #   #1-2. 틀리면 flash로 이미 가입된 메일입니다! redirect_to :back
    #   flash[:alert] = "이미 가입된 메일입니다!"
    #   redirect_to :back
    #
    # else
    #   #1-1. 맞으면 비밀번호 확인
    #     if params[:password]==params[:password_confirmation]
    #   #1-1-1. 비밀번호가 맞으면 가입
    #       User.create(username: params[:username], email: params[:email], password: params[:password])
    #       username=params[:username]
    #       flash[:notice] = "#{username}님  회원가입완료:)"
    #
    #   #1-1-2. 비밀번호가 서로 틀리면 flash & redirect_to
    #     else
    #       flash[:alert] = "비밀번호 다시 확인!"
    #       redirect_to :back
    #     end
    #
    # end
  end


  def login
  end

  def loginprocess
    user=User.find_by(email: params[:email])

    if user
    #이메일이 가입되었는지 확인
    #가입되었으면 비밀번호 확인
      if user.authenticate(params[:password])
    #비밀번호가 일치하면 로그인
        session[:user_id]=user.id
        flash[:notice]="#{user.username} Login Complete :)"
        redirect_to "/"


      else
    #비밀번호가 다르면 flash & :back
        flash[:alert]="check your password"
        redirect_to :back
      end
    else
    #가입이 안됐으면 가입하는 곳으로
      flash[:alert]="Sign up first"
      redirect_to "/signup"
    end




  end


  def logout
    session.clear
    flash[:notice]="logout!"
    redirect_to "/"
  end


end
